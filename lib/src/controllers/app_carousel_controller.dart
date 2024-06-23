import 'package:flutter/material.dart';

class AppCarouselController extends PageController {
  AppCarouselController({
    int initialPage = 0,
    double viewportFraction = 1.0,
    bool keepPage = true,
  }) : super( initialPage: initialPage, viewportFraction: viewportFraction, keepPage: keepPage, );

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  
  void setCurrentPageIndex(int pageIndex) {
    _currentPageIndex = pageIndex;
  }

  Future<void> _animateToPage(int page, {Duration duration = const Duration(milliseconds: 1000), Curve curve = Curves.ease}) {
    if (hasClients) {
      return super.animateToPage(
        page,
        curve: curve,
        duration: duration,
      );
    }
    return Future(() => null);
  }

  void goNext({required int currentPage}) {
    _animateToPage(currentPage + 1);
  }

  void goBack({required int currentPage}) {
    if (hasClients && page != null) {
      _animateToPage(currentPage - 1);
    }
  }

  Future<void> animatedJumpToPage({required int page}) async {
    const animationSpeed = 2000;
    const delayDuration = 1500;

    for(int otherPages = 1; otherPages <= page; otherPages++) {
      _animateToPage(otherPages, duration: const Duration(milliseconds: animationSpeed));
      await Future.delayed(const Duration(milliseconds: delayDuration));
    }
  }
}
