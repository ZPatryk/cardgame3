import 'package:flutter/material.dart';

class GradientAnimationWidget extends StatefulWidget {
  final List<Color> colors; // Lista kolorów dla gradientu
  final Duration duration; // Czas trwania animacji
  final Widget child; // Opcjonalne dziecko

  const GradientAnimationWidget({super.key,
    required this.colors,
    this.duration = const Duration(seconds: 6),
    required this.child,
  });

  @override
  _GradientAnimationWidgetState createState() => _GradientAnimationWidgetState();
}

class _GradientAnimationWidgetState extends State<GradientAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true); // Powtarzanie animacji z efektem cofania

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0.0),
              end: Alignment(1.0 + _animation.value, 0.0),
              colors: widget.colors,
              stops: const [0.0, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
