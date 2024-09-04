import 'dart:math';
import 'package:flutter/material.dart';

class CardFlip extends StatefulWidget {
  final String frontImagePath;
  final String backImagePath;
  final VoidCallback onTap; // Callback do obsługi kliknięć.

  const CardFlip({
    required this.frontImagePath,
    required this.backImagePath,
    required this.onTap, // Inicjalizacja callbacku.
    super.key,
  });

  @override
  State<CardFlip> createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _flipCard() {
    _controller.forward().then((_) {
      setState(() {
        _showFront = !_showFront;
      });
      _controller.reverse(); // Powrót animacji do początkowej wartości.
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _flipCard();
        widget.onTap(); // Wywołanie callbacku.
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double angle = _animation.value * pi;
          final isUnder = _animation.value > 0.5;
          var tilt = (1 - _animation.value - 0.5).abs() - 0.5;
          tilt *= isUnder ? -0.005 : 0.005;

          final transform = Matrix4.rotationY(angle)..setEntry(3, 0, tilt);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: _animation.value < 0.5
                ? SizedBox(
              width: 200,
              height: 300,
              child: Image.asset(
                widget.frontImagePath,
                fit: BoxFit.cover,
              ),
            )
                : Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                height: 300,
                child: Image.asset(
                  widget.backImagePath,
                  fit: BoxFit.cover,
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
    _controller.dispose();
    super.dispose();
  }
}
