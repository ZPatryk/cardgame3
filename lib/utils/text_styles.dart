import 'package:flutter/material.dart';

class TextStyles {
  // Styl nagłówków
  static const TextStyle header = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Styl dla podtytułów
  static const TextStyle subHeader = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black54,
  );

  // Styl dla treści
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );

  // Styl dla linków
  static const TextStyle link = TextStyle(
    fontSize: 14,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  // styl retro
  static const TextStyle retro = TextStyle(
    fontSize: 14,
    fontFamily: 'PressStart2P',
    color: Colors.blue,
  );

  static const TextStyle retroblack = TextStyle(
    fontSize: 14,
    fontFamily: 'PressStart2P',
    color: Colors.black,
  );
}
