import 'package:flutter/material.dart';
import 'start_screen.dart';
import 'package:cardgame/utils/geradient.dart';

class EndGamePage extends StatefulWidget {
  final int player1Score;
  final int player2Score;
  final String player1Name;
  final String player2Name;

  EndGamePage({
    required this.player1Score,
    required this.player2Score,
    required this.player1Name,
    required this.player2Name,
  });

  @override
  _EndGamePageState createState() => _EndGamePageState();
}

class _EndGamePageState extends State<EndGamePage> {
  late int higherScore;
  late String higherPlayer;

  @override
  void initState() {
    super.initState();

    // Określenie, który gracz ma więcej punktów
    if (widget.player1Score > widget.player2Score) {
      higherScore = widget.player1Score;
      higherPlayer = 'Gracz nr 1: ${widget.player1Name}';
    } else if (widget.player2Score > widget.player1Score) {
      higherScore = widget.player2Score;
      higherPlayer = 'Gracz nr 2: ${widget.player2Name}';
    } else {
      higherScore = widget.player1Score; // Remis, punkty są takie same
      higherPlayer = 'Remis';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gra zakończona!"),
      ),
      body: GradientWidget(
        reziseToAvoidBottomInset: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                higherPlayer == 'Remis'
                    ? 'Gra zakończona remisem!'
                    : '$higherScore punktów zdobył $higherPlayer',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => StartScreen()),
                  );
                },
                child: Text('Rozpocznij nową grę'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
