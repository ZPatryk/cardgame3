import 'package:flutter/material.dart';
import 'FlipAnimation.dart';

class CardFlip extends StatefulWidget {
  final String frontImagePath;
  final String backImagePath;
  final Duration firstFlipDelay;
  final Duration secondFlipDelay;
  final Duration coverDelay;

  const CardFlip({
    required this.frontImagePath,
    required this.backImagePath,
    required this.firstFlipDelay,
    required this.secondFlipDelay,
    required this.coverDelay,
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
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1, milliseconds: 500),
      // Ustawienie czasu trwania animacji.
      vsync: this, // Potrzebne do synchronizacji animacji.
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(_controller); // Definiowanie zakresu animacji (od 0 do 1).

    Future.delayed(widget.firstFlipDelay, () {
      _flipCard();
    });

    Future.delayed(widget.secondFlipDelay, () {
      _flipCard();
    });

    Future.delayed(widget.coverDelay, () {
      _coverCard();
    });
  }

  void _coverCard() {
    setState(() {
      _isVisible = false; // Ukrycie karty przez ustawienie flagi na false.
    });
  }

  void _flipCard() {
    _controller.forward().then((_) {
      setState(() {
        _showFront = !_showFront; // Zmiana stanu karty.
      });
      _controller.reverse(); // Powrót animacji do początkowej wartości.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sprawdzenie, czy karta powinna być widoczna
    if (!_isVisible) {
      return const SizedBox.shrink(); // Zwracanie pustego widgetu, gdy karta jest ukryta.
    }

    // Użycie nowej klasy FlipAnimation
    return FlipAnimation(
      animation: _animation,
      frontImagePath: widget.frontImagePath,
      backImagePath: widget.backImagePath,
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Zwolnienie zasobów kontrolera animacji.
    super.dispose();
  }
}
