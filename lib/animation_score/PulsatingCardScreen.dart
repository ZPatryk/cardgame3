import 'package:flutter/material.dart';

class PulsatingCardScreen extends StatefulWidget {
  @override
  _PulsatingCardScreenState createState() => _PulsatingCardScreenState(); // Tworzy stan dla ekranu.
}

class _PulsatingCardScreenState extends State<PulsatingCardScreen>
    with TickerProviderStateMixin { // TickerProviderStateMixin zapewnia vsync dla animacji.

  late AnimationController _scaleController; // Kontroler do zarządzania animacją skalowania.
  late AnimationController _shakeController; // Kontroler do zarządzania animacją trzęsienia.
  late Animation<double> _scaleAnimation; // Definicja animacji skalowania.
  late Animation<double> _shakeAnimation; // Definicja animacji trzęsienia.

  @override
  void initState() {
    super.initState();

    // Animacja pulsowania (skalowanie od 1.0 do 1.2)
    _scaleController = AnimationController(
      vsync: this, // Synchronizuje animację z cyklem życia widgetu.
      duration: const Duration(milliseconds: 1800), // Ustawia czas trwania animacji na 1.8 sekundy.
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
      // Definiuje animację skalowania z zakresem od 1.0 do 1.2 i krzywą EaseInOut.
    );

    // Animacja trzęsienia (przesunięcie od 0 do 16 pikseli na osi X)
    _shakeController = AnimationController(
      vsync: this, // Synchronizuje z cyklem życia widgetu.
      duration: const Duration(milliseconds: 400), // Czas trwania animacji trzęsienia wynosi 400 ms.
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 16).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
      // Tworzy efekt trzęsienia z zakresem przesunięcia od 0 do 16 pikseli z krzywą elastyczną.
    );

    // Uruchomienie animacji pulsowania (skalowanie)
    _scaleController.forward(); // Startuje animację skalowania.

    // Listener, który czeka na zakończenie animacji skalowania
    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) { // Gdy animacja skalowania dojdzie do końca
        _scaleController.reverse(); // Uruchomienie animacji w odwrotną stronę (zmniejszanie).
        _shakeController.forward(); // Po zakończeniu skalowania, uruchamia trzęsienie.
      }
    });

    // Listener do zakończenia trzęsienia
    _shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) { // Gdy animacja trzęsienia zakończy się
        _shakeController.reverse(); // Uruchamia trzęsienie w odwrotną stronę, wracając do normalnego położenia.
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose(); // Zwalnia zasoby używane przez _scaleController.
    _shakeController.dispose(); // Zwalnia zasoby używane przez _shakeController.
    super.dispose(); // Woła metodę dispose z nadklasy, aby zakończyć cykl życia widgetu.
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 33,
        child: AnimatedBuilder(
          animation: Listenable.merge([_scaleAnimation, _shakeAnimation]),
          // AnimatedBuilder reaguje na zmiany zarówno w animacji skalowania, jak i trzęsienia.
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_shakeAnimation.value, 0), // Przesuwa widget o wartość trzęsienia w osi X.
              child: Transform.scale(
                scale: _scaleAnimation.value, // Skaluje widget o wartość skalowania.
                child: Image.asset(
                  'assets/images/cards.png', // Ścieżka do obrazka w katalogu assets.
                  //width: 30,          // Szerokość obrazka.
                  //height: 50,         // Wysokość obrazka.
                  fit: BoxFit.cover,   // Dopasowanie obrazka w taki sposób, by wypełniał dostępny obszar.
                ),
              ),
            );
          },
        ),
    );
  }
}
