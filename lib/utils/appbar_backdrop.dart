import 'package:flutter/material.dart';

class BackdropAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color textColor;
  final List<Color> gradientColors;

  const BackdropAppBar({super.key,
    required this.title,
    this.textColor = Colors.white, // Domyślny kolor tekstu
    this.gradientColors = const [Colors.blue, Colors.purple], // Domyślny gradient
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 10.0, // Cień pod AppBarem
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors, // Kolory gradientu
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor, // Kolor tekstu
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Standardowa wysokość AppBara
}
