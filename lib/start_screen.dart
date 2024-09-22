import 'dart:math';
import 'package:cardgame/utils/geradient.dart';
import 'package:flutter/material.dart';
import 'image_item.dart';
import 'image_screen.dart';
import 'package:cardgame/utils/text_styles.dart';
import 'package:cardgame/animation/MultipleCard.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();
  final FocusNode _player1FocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _player1FocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    player1Controller.dispose();
    player2Controller.dispose();
    _player1FocusNode.dispose();
    super.dispose();
  }

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
      ImageItem(key: 'watermelon', imagePath: 'assets/images/image15.png'),
      ImageItem(key: 'watermelon1', imagePath: 'assets/images/image16.png'),
      ImageItem(key: 'pear', imagePath: 'assets/images/image17.png'),
      ImageItem(key: 'pear1', imagePath: 'assets/images/image18.png'),
      ImageItem(key: 'raspberry', imagePath: 'assets/images/image19.png'),
      ImageItem(key: 'raspberry1', imagePath: 'assets/images/image20.png'),
    ];

    const String frontImagePath = 'assets/images/image21.png';

    images.shuffle(Random());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(
          child: Text('Enter Player Names', style: TextStyles.retro),
        ),
      ),
      body: GradientWidget(
        reziseToAvoidBottomInset: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Dodanie widgetu `MultipleCardGridWrapper` na górze
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Opacity(
                  opacity: 0.3,
                   child: MultipleCardGridWrapper(
                    width: 150.0, // Cała szerokość ekranu
                    height: 150.0,
                  ),
                ),
              ),
              const SizedBox(height: 75),
              // Pozostałe elementy poniżej
              SizedBox(
                width: 250.0,
                child: TextField(
                  maxLength: 10,
                  controller: player1Controller,
                  focusNode: _player1FocusNode,
                  style: TextStyles.retroblack,
                  decoration: const InputDecoration(
                    label: Center(
                      child: Text(
                        'Player 1 Name',
                        style: TextStyles.retro,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 250.0,
                child: TextField(
                  maxLength: 10,
                  controller: player2Controller,
                  style: TextStyles.retroblack,
                  decoration: const InputDecoration(
                    label: Center(
                      child: Text(
                        'Player 2 Name',
                        style: TextStyles.retro,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String player1Name = player1Controller.text.isEmpty ? 'Player 1' : player1Controller.text;
                  String player2Name = player2Controller.text.isEmpty ? 'Player 2' : player2Controller.text;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageScreen(
                        images: images,
                        frontImagePath: frontImagePath,
                        player1Name: player1Name,
                        player2Name: player2Name,
                      ),
                    ),
                  );
                },
                child: const Text('Start Game', style: TextStyles.retro),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
