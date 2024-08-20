import 'package:flutter/material.dart';
import 'image_item.dart';
import 'image_screen.dart';

class StartScreen extends StatelessWidget {
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Zdefiniuj pełną listę obrazów tutaj
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Player Names'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: player1Controller,
              decoration: const InputDecoration(labelText: 'Player 1 Name'),
            ),
            TextField(
              controller: player2Controller,
              decoration: const InputDecoration(labelText: 'Player 2 Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageScreen(
                      images: images,  // Przekazujemy pełną listę obrazów
                      player1Name: player1Controller.text,
                      player2Name: player2Controller.text,
                    ),
                  ),
                );
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
