import 'package:flutter/material.dart';

class AppCarouselController extends PageController {
  AppCarouselController({
    int initialPage = 0,
    double viewportFraction = 1.0,
    bool keepPage = true,
  }) : super(
          initialPage: initialPage,
          viewportFraction: viewportFraction,
          keepPage: keepPage,
        );

  Future<void> _animateToPage(int page, {Duration duration = const Duration(milliseconds: 300), Curve curve = Curves.ease}) {
    if (hasClients) {
      return super.animateToPage(
        page,
        curve: curve,
        duration: duration,
      );
    }
    return Future(() => null);
  }

  void goNext(int currentPage) {
      _animateToPage(currentPage + 1);
  }

  void goBack(int currentPage) {
    if (hasClients && page != null) {
      _animateToPage(currentPage -1);
    }
  }
}
