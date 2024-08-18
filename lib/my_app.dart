import 'package:flutter/material.dart';
import 'image_item.dart'; // Upewnij się, że ścieżka do pliku jest poprawna
import 'image_screen.dart'; // Upewnij się, że ścieżka do pliku jest poprawna

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ImageItem> images = [
      ImageItem(key: 'apple', imagePath: 'assets/images/image1.png'),
      ImageItem(key: 'apple1', imagePath: 'assets/images/image2.png'),
      ImageItem(key: 'banana', imagePath: 'assets/images/image3.png'),
      ImageItem(key: 'banana1', imagePath: 'assets/images/image4.png'),
      ImageItem(key: 'cherry', imagePath: 'assets/images/image5.png'),
      ImageItem(key: 'cherry1', imagePath: 'assets/images/image6.png'),
      ImageItem(key: 'grape', imagePath: 'assets/images/image7.png'),
      ImageItem(key: 'grape1', imagePath: 'assets/images/image8.png'),
      ImageItem(key: 'lemon', imagePath: 'assets/images/image9.png'),
      ImageItem(key: 'lemon1', imagePath: 'assets/images/image10.png'),
      ImageItem(key: 'plum', imagePath: 'assets/images/image11.png'),
      ImageItem(key: 'plum1', imagePath: 'assets/images/image12.png'),
      ImageItem(key: 'strawberry', imagePath: 'assets/images/image13.png'),
      ImageItem(key: 'strawberry1', imagePath: 'assets/images/image14.png'),
      ImageItem(key: 'waterlemon', imagePath: 'assets/images/image15.png'),
      ImageItem(key: 'waterlemon1', imagePath: 'assets/images/image16.png'),
      ImageItem(key: 'pear', imagePath: 'assets/images/image17.png'),
      ImageItem(key: 'pear1', imagePath: 'assets/images/image18.png'),
      ImageItem(key: 'raspberry', imagePath: 'assets/images/image19.png'),
      ImageItem(key: 'raspberry1', imagePath: 'assets/images/image20.png'),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Card Game'),

        ),
        body: ImageScreen(images: images), // Zmienione na 'images'
      ),
    );
  }
}
