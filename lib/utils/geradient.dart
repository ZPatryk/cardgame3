import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;

  const GradientWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pierwszy kontener z gradientem
        Container(
          width: 800,
          height: 800,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 225, 133, 227), // Pierwszy kolor
                Color.fromARGB(255, 181, 80, 234),  // Drugi kolor
              ],
              radius: 1.0,
              center: Alignment.center,
            ),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 600,
          height: 600,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 225, 133, 227), // Pierwszy kolor
                Color.fromARGB(255, 181, 80, 234),  // Drugi kolor
              ],
              radius: 1.0,
              center: Alignment.center,
            ),
            shape: BoxShape.circle,
          ),
        ),
        // Drugi kontener z gradientem
        Container(
          width: 270,
          height: 270,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 181, 80, 234), // Trzeci kolor
                Color.fromARGB(255, 225, 133, 227), // Czwarty kolor
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
