import 'package:flutter/material.dart';

class FadeImagesController extends AnimationController {

  FadeImagesController(TickerProvider vsync) : super(
    duration: const Duration(milliseconds: 3000),
    vsync: vsync
  );

  Animation<double> get opacityAnimation => Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(this);

  void startAnimation() {
    forward();
  }
}
