import 'dart:ui';
import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;

  const GradientWidget({
    super.key,
    required this.child, required bool reziseToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
                  // Pierwszy kontener z gradientem
          OverflowBox(
            maxWidth: 1200, // Ustaw szerokość większą niż ekran
            maxHeight: 1200, // Ustaw wysokość większą niż ekran
            child: Container(
              width: 1200,
              height: 1200,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(255, 183, 102, 228), // Pierwszy kolor
                    Color.fromARGB(255, 215, 110, 236), // Drugi kolor
                  ],
                  radius: 1.0,
                  center: Alignment.center,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          OverflowBox(
            maxWidth: 900, // Ustaw szerokość większą niż ekran
            maxHeight: 900, // Ustaw wysokość większą niż ekran
            child: Container(
              width: 700,
              height: 700,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(255, 225, 133, 227), // Pierwszy kolor
                    Color.fromARGB(255, 181, 80, 234), // Drugi kolor
                  ],
                  radius: 1.0,
                  center: Alignment.center,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          OverflowBox(
            maxHeight: 480,
            maxWidth: 480,
            child: Container(
              width: 500,
              height: 500,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(255, 220, 106, 222), // Trzeci kolor
                    Color.fromARGB(255, 223, 164, 225), // Drugi kolor
                  ],
                  radius: 1.0,
                  center: Alignment.center,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Drugi kontener z gradientem
          Container(
            width: 270,
            height: 270,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 225, 133, 227), // Trzeci kolor
                  Color.fromARGB(255, 236, 180, 236), // Czwarty kolor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
          ),
          // Kontener z dzieckiem
          Center(child: child),

      ],
    );
  }
}
