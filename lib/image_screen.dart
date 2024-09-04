import 'package:flutter/material.dart';
import 'image_item.dart';
import 'card_flip.dart'; // Import klasy do obsługi obracania kart.

class ImageScreen extends StatefulWidget {
  final List<ImageItem> images; // Lista obrazów (kart) do wyświetlenia.
  final String frontImagePath; // Ścieżka do obrazu rewersu kart.
  final String player1Name; // Nazwa gracza 1.
  final String player2Name; // Nazwa gracza 2.

  const ImageScreen({
    super.key,
    required this.images, // Wymagane: Lista obrazów.
    required this.frontImagePath, // Wymagane: Ścieżka do obrazu rewersu.
    required this.player1Name, // Wymagane: Nazwa gracza 1.
    required this.player2Name, // Wymagane: Nazwa gracza 2.
  });

  @override
  _ImageScreenState createState() => _ImageScreenState(); // Tworzy stan dla ImageScreen.
}

class _ImageScreenState extends State<ImageScreen> {
  late Map<String, bool> _visible; // Mapa, która śledzi widoczność każdej karty.
  late String? _firstSelectedKey; // Klucz pierwszej wybranej karty.
  late String? _secondSelectedKey; // Klucz drugiej wybranej karty.

  int _player1Score = 0; // Wynik gracza 1.
  int _player2Score = 0; // Wynik gracza 2.
  int _currentPlayer = 1; // Aktualny gracz (1 lub 2).

  @override
  void initState() {
    super.initState();
    _visible = {for (var item in widget.images) item.key: true}; // Inicjalizacja widoczności kart, wszystkie karty są widoczne.
    _firstSelectedKey = null; // Pierwsza wybrana karta jest pusta (brak wybranej).
    _secondSelectedKey = null; // Druga wybrana karta jest pusta (brak wybranej).
  }

  void _handleTap(String key) {
    // Jeśli karta jest już niewidoczna lub dwie karty są już wybrane, nic nie rób.
    if (!_visible[key]! || (_firstSelectedKey != null && _secondSelectedKey != null)) {
      return;
    }

    setState(() {
      if (_firstSelectedKey == null) {
        _firstSelectedKey = key; // Zapisz klucz pierwszej wybranej karty.
      } else {
        _secondSelectedKey = key; // Zapisz klucz drugiej wybranej karty.

        String pairedKey = _firstSelectedKey!.endsWith('1')
            ? _firstSelectedKey!.replaceAll('1', '')
            : '${_firstSelectedKey!}1';

        // Sprawdź, czy wybrane karty do siebie pasują.
        if (pairedKey == _secondSelectedKey) {
          // Dodaj opóźnienie, aby druga karta mogła się odsłonić do końca przed zniknięciem.
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              _visible[_firstSelectedKey!] = false; // Ukryj pierwszą kartę.
              _visible[_secondSelectedKey!] = false; // Ukryj drugą kartę.
            });

            if (_currentPlayer == 1) {
              _player1Score++; // Dodaj punkt graczowi 1.
            } else {
              _player2Score++; // Dodaj punkt graczowi 2.
            }

            _firstSelectedKey = null; // Zresetuj wybory kart.
            _secondSelectedKey = null; // Zresetuj wybory kart.
          });
        } else {
          // Jeśli karty nie pasują, zmień gracza po krótkim opóźnieniu.
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _currentPlayer = _currentPlayer == 1 ? 2 : 1; // Przełącz na drugiego gracza.
              _firstSelectedKey = null; // Zresetuj wybory kart.
              _secondSelectedKey = null; // Zresetuj wybory kart.
            });
          });
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gra w Karty'), // Tytuł aplikacji.
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.player1Name} Wynik: $_player1Score', // Wyświetl wynik gracza 1.
              style: TextStyle(
                fontWeight: _currentPlayer == 1 ? FontWeight.bold : FontWeight.normal, // Pogrubienie tekstu, jeśli to tura gracza 1.
                fontSize: 24, // Rozmiar czcionki.
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Liczba kolumn w siatce.
                crossAxisSpacing: 4.0, // Odstęp między kolumnami.
                mainAxisSpacing: 4.0, // Odstęp między wierszami.
                childAspectRatio: 0.75, // Proporcje szerokości do wysokości kart.
              ),
              itemCount: widget.images.length, // Liczba elementów (kart) do wyświetlenia.
              itemBuilder: (context, index) {
                final item = widget.images[index]; // Pobierz odpowiedni element z listy obrazów.

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Visibility(
                    visible: _visible[item.key]!, // Sprawdza, czy karta powinna być widoczna.
                    child: CardFlip(
                      frontImagePath: widget.frontImagePath, // Ścieżka do obrazu rewersu karty.
                      backImagePath: item.imagePath, // Ścieżka do obrazu awersu karty.
                      key: ValueKey(item.key), // Klucz identyfikujący tę kartę.
                      onTap: () => _handleTap(item.key), // Wywołaj metodę obsługi kliknięcia po kliknięciu w kartę.
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.player2Name} Wynik: $_player2Score', // Wyświetl wynik gracza 2.
              style: TextStyle(
                fontWeight: _currentPlayer == 2 ? FontWeight.bold : FontWeight.normal, // Pogrubienie tekstu, jeśli to tura gracza 2.
                fontSize: 24, // Rozmiar czcionki.
              ),
            ),
          ),
        ],
      ),
    );
  }
}
