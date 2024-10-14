import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

class DetailScreen extends StatelessWidget {
  final Character character;
  const DetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(character.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.40,
              width: double.infinity,
              child: Hero(
                tag: character.id,
                child: Image.network(character.image, fit: BoxFit.cover),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              height: size.height * 0.10,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCard('Gender', character.gender),
                  buildCard('Species', character.species),
                  buildCard('Status', character.status)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildCard(String key, String value) {
  return Expanded(
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(key),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(overflow: TextOverflow.ellipsis))
        ],
      ),
    ),
  );
}
