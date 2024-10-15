import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../presentation/blocs/local_character_bloc/local_character_bloc.dart';

class LocalCharactersScreen extends StatefulWidget {
  const LocalCharactersScreen({super.key});

  @override
  State<LocalCharactersScreen> createState() => _LocalCharactersScreenState();
}

class _LocalCharactersScreenState extends State<LocalCharactersScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();

    context.read<LocalCharacterBloc>().add(FetchLocalCharactersEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de favoritos'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<LocalCharacterBloc, LocalCharacterState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocalCharacterLoaded) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.characters.length,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final character = state.characters[index];
                      return GestureDetector(
                        onTap: () {
                          context.go('/detail', extra: character);
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: size.width,
                                height: size.height,
                                child: Hero(
                                  tag: character.id,
                                  child: Image.network(
                                    (character.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    (character.name),
                                    style: GoogleFonts.montserratAlternates(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else if (state is CharactersError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}