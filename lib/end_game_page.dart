import 'package:flutter/material.dart';
import 'image_screen.dart';
import 'start_screen.dart';

class EndGamePage extends StatelessWidget {
  final int player1Score;
  final int player2Score;

  EndGamePage({required this.player1Score, required this.player2Score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gra zakończona!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wynik: Gracz 1: $player1Score, Gracz 2: $player2Score"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => StartScreen()),
                );
              },
              child: Text("Zagraj ponownie"),
            ),
          ],
        ),
      ),
    );
  }
}
