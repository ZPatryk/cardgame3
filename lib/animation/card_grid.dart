import 'package:flutter/material.dart';
import '../Image_item.dart';
import 'card_flip.dart'; // Import klasy CardFlip

class SingleCardView1 extends StatelessWidget {
  const SingleCardView1({super.key});

  @override
  Widget build(BuildContext context) {
    // Ustawienie jednego przodu (front) jako obiekt ImageItem
    final ImageItem frontImage = ImageItem(imagePath: 'assets/images/image21.png', key: '');

    // Obiekt ImageItem dla tyłu (back)
    final ImageItem backImage = ImageItem(imagePath: 'assets/images/image1.png', key: '');

    // Możemy użyć SizedBox, Container, CardFlip lub inny widget, zależnie od potrzeb
    return SizedBox(
      width: 150, // Szerokość karty
      height: 200, // Wysokość karty
      child: CardFlip(
        frontImagePath: frontImage.imagePath,
        backImagePath: backImage.imagePath,
        firstFlipDelay: const Duration(seconds: 1),
        secondFlipDelay: const Duration(seconds: 7),
        coverDelay: const Duration(seconds: 8, milliseconds: 500),
      ),
    );
  }
}

// Klasa 2
class SingleCardView2 extends StatelessWidget {
  const SingleCardView2({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageItem frontImage = ImageItem(imagePath: 'assets/images/image21.png', key: '');
    final ImageItem backImage = ImageItem(imagePath: 'assets/images/image2.png', key: '');

    return SizedBox(
      width: 150,
      height: 200,
      child: CardFlip(
        frontImagePath: frontImage.imagePath,
        backImagePath: backImage.imagePath,
        firstFlipDelay: const Duration(seconds: 4),
        secondFlipDelay: const Duration(seconds: 10),
        coverDelay: const Duration(seconds: 11, milliseconds: 500),
      ),
    );
  }
}

//klasa 3
class SingleCardView3 extends StatelessWidget {
  const SingleCardView3({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageItem frontImage = ImageItem(imagePath: 'assets/images/image21.png', key: '');
    final ImageItem backImage = ImageItem(imagePath: 'assets/images/image2.png', key: '');

    return SizedBox(
      width: 150,
      height: 200,
      child: CardFlip(
        frontImagePath: frontImage.imagePath,
        backImagePath: backImage.imagePath,
        firstFlipDelay: const Duration(seconds: 1),
        secondFlipDelay: const Duration(seconds: 10),
        coverDelay: const Duration(seconds: 11, milliseconds: 500),
      ),
    );
  }
}

//klasa 4
class SingleCardView4 extends StatelessWidget {
  const SingleCardView4({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageItem frontImage = ImageItem(imagePath: 'assets/images/image21.png', key: '');
    final ImageItem backImage = ImageItem(imagePath: 'assets/images/image1.png', key: '');

    return SizedBox(
      width: 150,
      height: 200,
      child: CardFlip(
        frontImagePath: frontImage.imagePath,
        backImagePath: backImage.imagePath,
        firstFlipDelay: const Duration(seconds: 4),
        secondFlipDelay: const Duration(seconds: 7),
        coverDelay: const Duration(seconds: 8, milliseconds: 500),
      ),
    );
  }
}

