import 'dart:math';

import 'package:flutter/material.dart';

class AutoRotatingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AutoRotatingWidget({
    super.key,
    this.duration = const Duration(seconds: 1),
    required this.child,
  });

  @override
  State<AutoRotatingWidget> createState() => _AutoRotatingWidgetState();
}

class _AutoRotatingWidgetState extends State<AutoRotatingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: widget.child,
        );
      },
    );
  }
}
