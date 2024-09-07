import 'dart:math'; // Importuje bibliotekę matematyczną do użycia wartości pi.
import 'package:flutter/material.dart'; // Importuje bibliotekę Flutter do budowy UI.

class CardFlip extends StatefulWidget {
  final String frontImagePath; // Ścieżka do obrazu wyświetlanego na przodzie karty.
  final String backImagePath; // Ścieżka do obrazu wyświetlanego na tyle karty.
  final VoidCallback onTap; // Callback wywoływany podczas kliknięcia na kartę.

  const CardFlip({
    required this.frontImagePath, // Wymagana ścieżka obrazu dla przodu karty.
    required this.backImagePath, // Wymagana ścieżka obrazu dla tyłu karty.
    required this.onTap, // Inicjalizacja callbacku kliknięcia.
    super.key,
  });

  @override
  State<CardFlip> createState() => CardFlipState(); // Tworzy stan dla widgetu CardFlip.
}

class CardFlipState extends State<CardFlip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Kontroler animacji dla obrotu karty.
  late Animation<double>
      _animation; // Animacja do przejścia wartości od 0 do 1.

  bool _showFront = true; // Flaga do śledzenia, czy przód karty jest widoczny.

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1, milliseconds: 500),
      // Ustawia czas trwania animacji na 1,5 sekundy.
      vsync: this, // Używa SingleTickerProviderStateMixin do animacji.
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(_controller); // Definiuje animację z wartościami od 0 do 1.
  }

  // Metoda odpowiedzialna za obrócenie karty.
  void _flipCard() {
    _controller.forward().then((_) {
      // Rozpoczyna animację obrotu.
      setState(() {
        _showFront =
            !_showFront; // Zmienia stronę karty na przeciwną po zakończeniu animacji.
      });
      //_controller.reverse(); // Cofanie animacji do początkowej wartości.____________________________________//////////////////
    });
  }

  void reverse() {
    _controller.reverse(); //Cofanie animacji do początkowej wartości
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _flipCard(); // Obraca kartę po kliknięciu.
        widget.onTap(); // Wywołuje callback na kliknięcie karty.
      },
      child: AnimatedBuilder(
        animation: _animation, // Powiązuje animację z widgetem.
        builder: (context, child) {
          double angle = _animation.value *
              pi; // Oblicza kąt obrotu na podstawie wartości animacji.
          final isUnder = _animation.value >
              0.5; // Sprawdza, czy karta jest w drugiej połowie obrotu.
          var tilt = (1 - _animation.value - 0.5).abs() -
              0.5; // Oblicza delikatne przechylenie podczas obrotu.
          tilt *= isUnder
              ? -0.005
              : 0.005; // Zmienia kierunek przechylenia w zależności od strony karty.

          final transform = Matrix4.rotationY(angle)
            ..setEntry(3, 0, tilt); // Ustawia macierz transformacji dla obrotu.

          return Transform(
            transform: transform,
            // Aplikuje transformację do widgetu.
            alignment: Alignment.center,
            // Ustawia środek obrotu na środek widgetu.
            child: _animation.value <
                    0.5 // Sprawdza, czy animacja jest w pierwszej połowie.
                ? SizedBox(
                    width: 200, // Ustawia szerokość widgetu.
                    height: 300, // Ustawia wysokość widgetu.
                    child: Image.asset(
                      widget.frontImagePath, // Wyświetla obraz przodu karty.
                      fit: BoxFit.cover, // Dopasowuje obraz do rozmiaru karty.
                    ),
                  )
                : Transform(
                    transform: Matrix4.rotationY(pi),
                    // Obraca kartę o 180 stopni w poziomie, aby wyświetlić tył.
                    alignment: Alignment.center,
                    // Ustawia środek obrotu na środek widgetu.
                    child: SizedBox(
                      width: 200, // Ustawia szerokość widgetu.
                      height: 300, // Ustawia wysokość widgetu.
                      child: Image.asset(
                        widget.backImagePath, // Wyświetla obraz tyłu karty.
                        fit:
                            BoxFit.cover, // Dopasowuje obraz do rozmiaru karty.
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
    _controller.dispose(); // Usuwa kontroler animacji przy zamykaniu widgetu.
    super.dispose();
  }
}
