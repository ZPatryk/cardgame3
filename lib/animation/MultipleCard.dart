import 'package:flutter/material.dart';
import 'card_grid.dart'; // Import odpowiednich klas kart


class MultipleCardGridWrapper extends StatelessWidget {
  final double width; // Szerokość całego widgetu
  final double height; // Wysokość całego widgetu

  const MultipleCardGridWrapper({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Ustawienie szerokości widgetu
      height: height, // Ustawienie wysokości widgetu
      child: GridView.count(
        crossAxisCount: 2, // Liczba kolumn
        mainAxisSpacing: 10.0, // Odstęp pionowy między kartami
        crossAxisSpacing: 10.0, // Odstęp poziomy między kartami
        children: const [
          SingleCardView1(), // Pierwsza karta
          SingleCardView2(), // Druga karta
          SingleCardView3(), // Trzecia karta
          SingleCardView4(), // Czwarta karta
        ],
      ),
    );
  }
}
