import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Rick and Morty',
        style: GoogleFonts.montserratAlternates(
          fontSize: 50,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}