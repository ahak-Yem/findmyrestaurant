import 'package:flutter/material.dart';

class AppCarouselController<T> extends ChangeNotifier {
  final PageController _pageController = PageController();

  int get currentPage => _pageController.page?.round() ?? 0;

  void animateToPage(int page, {Duration duration = const Duration(milliseconds: 300), Curve curve = Curves.ease}) {
    _pageController.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
