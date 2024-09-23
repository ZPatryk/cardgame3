import 'package:cardgame/utils/geradient.dart';
import 'package:flutter/material.dart';
import 'animation_score/PulsatingCardScreen.dart';
import 'image_item.dart';
import 'card_flip.dart';
import 'end_game_page.dart';


class ImageScreen extends StatefulWidget {
  final List<ImageItem>
      images; // Lista obrazów (kart) do wyświetlenia na ekranie.
  final String
      frontImagePath; // Ścieżka do obrazu, który będzie używany jako rewers karty.
  final String player1Name; // Nazwa gracza 1.
  final String player2Name; // Nazwa gracza 2.

  const ImageScreen({
    super.key, // Klucz dla widgetu.
    required this.images, // Przekazuje listę obrazów.
    required this.frontImagePath, // Przekazuje ścieżkę do obrazu rewersu.
    required this.player1Name, // Przekazuje nazwę gracza 1.
    required this.player2Name, // Przekazuje nazwę gracza 2.
  });

  @override
  _ImageScreenState createState() =>
      _ImageScreenState(); // Tworzy stan dla ImageScreen.
}

class _ImageScreenState extends State<ImageScreen> {
  late Map<String, bool>
      _visible; // Mapa śledząca widoczność kart, klucz to identyfikator karty, wartość to bool (czy karta jest widoczna).
  late String? _firstSelectedKey; // Klucz pierwszej wybranej karty.
  late String? _secondSelectedKey; // Klucz drugiej wybranej karty.

  int _player1Score = 0; // Wynik gracza 1.
  int _player2Score = 0; // Wynik gracza 2.
  int _currentPlayer = 1; // Aktualny gracz (1 lub 2).
  bool _isPlayer1Animating = false; // Flaga animacji dla gracza 1.
  bool _isPlayer2Animating = false; // Flaga animacji dla gracza 2.

  // Dodajemy GlobalKey dla CardFlip, aby kontrolować animacje kart.
  final Map<String, GlobalKey<CardFlipState>> _cardKeys = {};

  @override
  void initState() {
    super.initState();
    // Inicjalizacja widoczności kart (wszystkie karty są początkowo widoczne).
    _visible = {for (var item in widget.images) item.key: true};
    _firstSelectedKey = null; // Brak wybranej karty początkowo.
    _secondSelectedKey = null; // Brak drugiej wybranej karty początkowo.

    // Inicjalizacja kluczy dla każdej karty.
    for (var item in widget.images) {
      _cardKeys[item.key] = GlobalKey<CardFlipState>();
    }
  }

  void _reverseBothCards() {
    if (_firstSelectedKey != null && _secondSelectedKey != null) {
      // Wywołaj metodę reverse na obu kartach, jeśli są wybrane.
      _cardKeys[_firstSelectedKey]?.currentState?.reverse();
      _cardKeys[_secondSelectedKey]?.currentState?.reverse();
    }
  }

  void _handleTap(String key) {
    if (!_visible[key]! || (_firstSelectedKey != null && _secondSelectedKey != null)) {
      return;
    }

    setState(() {
      if (_firstSelectedKey == null) {
        _firstSelectedKey = key;
      } else {
        _secondSelectedKey = key;

        String pairedKey = _firstSelectedKey!.endsWith('1')
            ? _firstSelectedKey!.replaceAll('1', '')
            : '${_firstSelectedKey!}1';

        if (pairedKey == _secondSelectedKey) {
          Future.delayed(const Duration(seconds: 1, milliseconds: 250), () {
            if (mounted) {
              setState(() {
                _visible[_firstSelectedKey!] = false;
                _visible[_secondSelectedKey!] = false;

                if (_currentPlayer == 1) {
                  _player1Score++;
                  _isPlayer1Animating = true;
                  _isPlayer2Animating = false;
                } else {
                  _player2Score++;
                  _isPlayer2Animating = true;
                  _isPlayer1Animating = false;
                }

                _firstSelectedKey = null;
                _secondSelectedKey = null;
              });

              // Kolejne opóźnienie, aby upewnić się, że wynik jest w pełni zaktualizowany
              Future.delayed(const Duration(milliseconds: 500), () {
                // Debugowanie
                print('Wynik Gracz 1: $_player1Score, Wynik Gracz 2: $_player2Score');

                if (_player1Score + _player2Score == 10) {
                  print('Gra zakończona!');

                  // Opóźnienie przed nawigacją, aby gra mogła zakończyć animacje
                  Future.delayed(const Duration(milliseconds: 250), () {
                    if (mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => EndGamePage(
                            player1Score: _player1Score,
                            player2Score: _player2Score,
                          ),
                        ),
                      );
                    }
                  });
                }
              });
            }
          });
        } else {
          Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
            if (mounted) {
              _reverseBothCards();
              setState(() {
                _currentPlayer = _currentPlayer == 1 ? 2 : 1;
                _firstSelectedKey = null;
                _secondSelectedKey = null;
              });
            }
          });
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gra w Karty'), // Tytuł ekranu.
      ),
      body: GradientWidget(
        reziseToAvoidBottomInset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.player1Name}',
                    // Wyświetl wynik gracza 1.
                    style: TextStyle(
                      fontWeight: _currentPlayer == 1
                          ? FontWeight.bold
                          : FontWeight
                              .normal, // Pogrubienie tekstu dla aktualnego gracza.
                      fontSize: 24, // Rozmiar czcionki.
                    ),
                  ),
                  _isPlayer1Animating ? PulsatingCardScreen() : Container(),
                  Text(
                    '  $_player1Score',
                    // Wyświetl wynik gracza 1.
                    style: TextStyle(
                      fontWeight: _currentPlayer == 1
                          ? FontWeight.bold
                          : FontWeight
                          .normal, // Pogrubienie tekstu dla aktualnego gracza.
                      fontSize: 24, // Rozmiar czcionki.
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Liczba kolumn w siatce.
                  crossAxisSpacing: 4.0, // Odstęp między kolumnami.
                  mainAxisSpacing: 4.0, // Odstęp między wierszami.
                  childAspectRatio:
                      0.75, // Proporcje szerokości do wysokości kart.
                ),
                itemCount: widget.images.length, // Liczba kart do wyświetlenia.
                itemBuilder: (context, index) {
                  final item = widget.images[index]; // Pobierz kartę z listy.
        
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Visibility(
                      visible: _visible[item.key]!,
                      // Sprawdza, czy karta powinna być widoczna.
                      child: CardFlip(
                        frontImagePath: widget.frontImagePath,
                        // Ścieżka do obrazu rewersu karty.
                        backImagePath: item.imagePath,
                        // Ścieżka do obrazu awersu karty.
                        key: _cardKeys[item.key],
                        // Używa GlobalKey do kontrolowania stanu karty.
                        onTap: () => _handleTap(item
                            .key), // Wywołuje metodę obsługi kliknięcia karty.
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.player2Name}',
                    // Wyświetl wynik gracza 1.
                    style: TextStyle(
                      fontWeight: _currentPlayer == 2
                          ? FontWeight.bold
                          : FontWeight
                          .normal, // Pogrubienie tekstu dla aktualnego gracza.
                      fontSize: 24, // Rozmiar czcionki.
                    ),
                  ),
                  _isPlayer2Animating ? PulsatingCardScreen() : Container(),
                  Text(
                    '  $_player2Score',
                    // Wyświetl wynik gracza 1.
                    style: TextStyle(
                      fontWeight: _currentPlayer == 2
                          ? FontWeight.bold
                          : FontWeight
                          .normal, // Pogrubienie tekstu dla aktualnego gracza.
                      fontSize: 24, // Rozmiar czcionki.
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
