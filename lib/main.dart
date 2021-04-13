import 'package:donation_tracker/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.ralewayTextTheme(),
    ),
    themeMode: ThemeMode.light,
    home: HomeScreen(),
  ));
}
