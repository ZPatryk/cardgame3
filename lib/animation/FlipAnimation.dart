import 'dart:math';
import 'package:flutter/material.dart';

class FlipAnimation extends StatelessWidget {
  final Animation<double> animation;
  final String frontImagePath;
  final String backImagePath;

  const FlipAnimation({
    required this.animation,
    required this.frontImagePath,
    required this.backImagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Obliczanie kąta obrotu na podstawie wartości animacji.
        double angle = animation.value * pi;
        // Sprawdzanie, czy obecna strona jest spodnia.
        final isUnder = animation.value > 0.5;
        // Obliczanie delikatnego przechylenia dla efektu 3D.
        var tilt = (1 - animation.value - 0.5).abs() - 0.5;
        // Nakładanie przechylenia zależnie od strony.
        tilt *= isUnder ? -0.005 : 0.005;

        // Tworzenie przekształcenia z rotacją i przechyleniem.
        final transform = Matrix4.rotationY(angle)..setEntry(3, 0, tilt);

        return Transform(
          transform: transform, // Przekształcenie z rotacją w osi Y.
          alignment: Alignment.center, // Ustawienie środka obrotu.
          child: animation.value < 0.5
              ? SizedBox(
            //width: 200, // Szerokość karty.
            //height: 300, // Wysokość karty.
            child: Image.asset(
              frontImagePath, // Ścieżka do przedniego obrazu karty.
              fit: BoxFit.cover, // Dopasowanie obrazu do kontenera.
            ),
          )
              : Transform(
            transform: Matrix4.rotationY(pi),
            // Obrót o 180 stopni dla tylnej strony.
            alignment: Alignment.center,
            child: SizedBox(
              //width: 200, // Szerokość karty.
              //height: 300, // Wysokość karty.
              child: Image.asset(
                backImagePath, // Ścieżka do tylnego obrazu karty.
                fit: BoxFit.cover, // Dopasowanie obrazu do kontenera.
              ),
            ),
          ),
        );
      },
    );
  }
}
