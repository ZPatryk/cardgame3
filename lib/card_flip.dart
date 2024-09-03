import 'dart:math';
import 'package:flutter/material.dart';

class CardFlip extends StatefulWidget {
  final String frontImagePath;
  final String backImagePath;

  const CardFlip({
    required this.frontImagePath,
    required this.backImagePath,
    super.key,
  });

  @override
  State<CardFlip> createState() =>
      _CardFlipState(); // Tworzenie stanu widgetu CardFlip.
}

class _CardFlipState extends State<CardFlip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Kontroler animacji.
  late Animation<double> _animation; // Sama animacja.

  bool _showFront = true; // Flaga określająca, czy przód karty jest widoczny.

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      // Ustawienie czasu trwania animacji.
      vsync: this, // Potrzebne do synchronizacji animacji.
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(_controller); // Definiowanie zakresu animacji (od 0 do 1).
  }

  void _flipCard() {
    _controller.forward().then((_) {
      setState(() {
        _showFront = !_showFront; // Zmiana stanu karty.
      });
      //_controller.reverse(); // Powrót animacji do początkowej wartości.
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard, // Rejestrowanie kliknięcia, aby obrócić kartę.
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Obliczanie kąta obrotu na podstawie wartości animacji.
          double angle = _animation.value * pi;
          // Sprawdzanie, czy obecna strona jest spodnia.
          final isUnder = _animation.value > 0.5;
          // Obliczanie delikatnego przechylenia dla efektu 3D.
          var tilt = (1 - _animation.value - 0.5).abs() - 0.5;
          // Nakładanie przechylenia zależnie od strony.
          tilt *= isUnder ? -0.005 : 0.005;

          // Tworzenie przekształcenia z rotacją i przechyleniem.
          final transform = Matrix4.rotationY(angle)..setEntry(3, 0, tilt);

          return Transform(
            transform: transform, // Przekształcenie z rotacją w osi Y.
            alignment: Alignment.center, // Ustawienie środka obrotu.
            child: _animation.value < 0.5
                ? SizedBox(
                    width: 200, // Szerokość karty.
                    height: 300, // Wysokość karty.
                    child: Image.asset(
                      widget
                          .frontImagePath, // Ścieżka do przedniego obrazu karty.
                      fit: BoxFit.cover, // Dopasowanie obrazu do kontenera.
                    ),
                  )
                : Transform(
                    transform: Matrix4.rotationY(pi),
                    // Obrót o 180 stopni dla tylnej strony.
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200, // Szerokość karty.
                      height: 300, // Wysokość karty.
                      child: Image.asset(
                        widget
                            .backImagePath, // Ścieżka do tylnego obrazu karty.
                        fit: BoxFit.cover, // Dopasowanie obrazu do kontenera.
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Zwolnienie zasobów kontrolera animacji.
    super.dispose();
  }
}
