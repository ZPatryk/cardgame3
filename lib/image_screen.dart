import 'package:flutter/material.dart';
import 'image_item.dart'; // Import klasy ImageItem, która prawdopodobnie przechowuje informacje o obrazach kart.
import 'card_flip.dart'; // Import klasy CardFlip, która obsługuje animację obracania kart.

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
    // Jeśli karta jest już niewidoczna lub dwie karty są już wybrane, nic nie rób.
    if (!_visible[key]! ||
        (_firstSelectedKey != null && _secondSelectedKey != null)) {
      return;
    }

    setState(() {
      if (_firstSelectedKey == null) {
        _firstSelectedKey = key; // Zapisz klucz pierwszej wybranej karty.
      } else {
        _secondSelectedKey = key; // Zapisz klucz drugiej wybranej karty.

        // Sprawdza, czy wybrane karty pasują do siebie (na podstawie kluczy).
        String pairedKey = _firstSelectedKey!.endsWith('1')
            ? _firstSelectedKey!.replaceAll('1', '')
            : '${_firstSelectedKey!}1';

        if (pairedKey == _secondSelectedKey) {
          // Jeśli karty pasują, ukryj je po krótkim opóźnieniu.
          Future.delayed(const Duration(seconds: 0), () {
            setState(() {
              _visible[_firstSelectedKey!] = false; // Ukryj pierwszą kartę.
              _visible[_secondSelectedKey!] = false; // Ukryj drugą kartę.
            });

            // Dodaj punkt graczowi, który zdobył parę kart.
            if (_currentPlayer == 1) {
              _player1Score++;
            } else {
              _player2Score++;
            }

            // Zresetuj wybrane karty.
            _firstSelectedKey = null;
            _secondSelectedKey = null;
          });
        } else {
          Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
            // Jeśli karty nie pasują, obróć je z powrotem.
            _reverseBothCards();
            // Po krótkim opóźnieniu zmień gracza.
            Future.delayed(const Duration(seconds: 0, milliseconds: 500), () {
              setState(() {
                _currentPlayer =
                    _currentPlayer == 1 ? 2 : 1; // Zmień aktualnego gracza.
                _firstSelectedKey = null; // Zresetuj wybrane karty.
                _secondSelectedKey = null; // Zresetuj wybrane karty.
              });
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
        title: const Text('Gra w Karty'), // Tytuł ekranu.
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.player1Name} Wynik: $_player1Score',
              // Wyświetl wynik gracza 1.
              style: TextStyle(
                fontWeight: _currentPlayer == 1
                    ? FontWeight.bold
                    : FontWeight
                        .normal, // Pogrubienie tekstu dla aktualnego gracza.
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
            child: Text(
              '${widget.player2Name} Wynik: $_player2Score',
              // Wyświetl wynik gracza 2.
              style: TextStyle(
                fontWeight: _currentPlayer == 2
                    ? FontWeight.bold
                    : FontWeight
                        .normal, // Pogrubienie tekstu dla aktualnego gracza.
                fontSize: 24, // Rozmiar czcionki.
              ),
            ),
          ),
        ],
      ),
    );
  }
}
