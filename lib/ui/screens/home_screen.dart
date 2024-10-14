import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/ui/widgets/search_delegate.dart';
import '../../presentation/blocs/character_bloc/character_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;
  late int currentPage = 1;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        currentPage++;
        context.read<CharacterBloc>().add(FetchCharactersEvent(currentPage));
      }
    });

    context.read<CharacterBloc>().add(FetchCharactersEvent(currentPage));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture Example'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchCharacter());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterLoaded) {
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
