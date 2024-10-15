import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

import '../../data/data_sources/database_helper.dart';
import '../../data/models/character_model.dart';

class DetailScreen extends StatefulWidget {
  final Character character;

  const DetailScreen({super.key, required this.character});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<bool> _isFavoriteFuture;

  @override
  void initState() {
    super.initState();
    _isFavoriteFuture = _loadFavoriteStatus();
  }

  Future<bool> _loadFavoriteStatus() async {
    final databaseHelper = DatabaseHelper();
    CharacterModel? character =
        await databaseHelper.getCharacterById(widget.character.id);
    return character?.isFavorite ?? false;
  }

  void toggleFavorite(bool isFavorite) async {
    final newStatus = !isFavorite;

    setState(() {
      _isFavoriteFuture = Future.value(newStatus);
    });

    final databaseHelper = DatabaseHelper();

    final existingCharacter =
        await databaseHelper.getCharacterById(widget.character.id);

    if (existingCharacter == null) {
      await databaseHelper.insertCharacter(widget.character);
    }

    await databaseHelper.updateFavorite(widget.character.id, newStatus);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.character.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
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
                tag: widget.character.id,
                child: Image.network(widget.character.image, fit: BoxFit.cover),
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
                  buildCard('Gender', widget.character.gender),
                  buildCard('Species', widget.character.species),
                  buildCard('Status', widget.character.status),
                ],
              ),
            ),
            FutureBuilder<bool>(
              future: _isFavoriteFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading favorite status');
                } else {
                  final isFavorite = snapshot.data ?? false;
                  return ElevatedButton(
                    onPressed: () => toggleFavorite(isFavorite),
                    child: Text(isFavorite
                        ? 'Remove from Favorites'
                        : 'Add to Favorites'),
                  );
                }
              },
            ),
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
          Text(value, style: const TextStyle(overflow: TextOverflow.ellipsis)),
        ],
      ),
    ),
  );
}
