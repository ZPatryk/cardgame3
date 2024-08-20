import 'package:flutter/material.dart';
import 'image_item.dart';

class ImageScreen extends StatefulWidget {
  final List<ImageItem> images;
  final String player1Name;
  final String player2Name;

  const ImageScreen({
    super.key,
    required this.images,
    required this.player1Name,
    required this.player2Name,
  });

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late Map<String, bool> _visible;
  late String? _firstSelectedKey;
  late String? _secondSelectedKey;

  int _player1Score = 0;
  int _player2Score = 0;
  int _currentPlayer = 1;

  @override
  void initState() {
    super.initState();
    _visible = {for (var item in widget.images) item.key: true};
    _firstSelectedKey = null;
    _secondSelectedKey = null;
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
          _visible[_firstSelectedKey!] = false;
          _visible[_secondSelectedKey!] = false;

          if (_currentPlayer == 1) {
            _player1Score++;
          } else {
            _player2Score++;
          }
        } else {
          _currentPlayer = _currentPlayer == 1 ? 2 : 1;
        }

        _firstSelectedKey = null;
        _secondSelectedKey = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Game'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.player1Name} Score: $_player1Score',
              style: TextStyle(
                fontWeight: _currentPlayer == 1 ? FontWeight.bold : FontWeight.normal,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 0.75
              ),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                final item = widget.images[index];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.deepPurple,
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Visibility(
                      visible: _visible[item.key] ?? false,
                      child: InkWell(
                        onTap: () => _handleTap(item.key),
                        child: Image.asset(item.imagePath),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.player2Name} Score: $_player2Score',
              style: TextStyle(
                fontWeight: _currentPlayer == 2 ? FontWeight.bold : FontWeight.normal,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
