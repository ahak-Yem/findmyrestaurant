import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/components/app%20buttons/arrow_button.dart';
import 'package:findmyrestaurant/src/components/dot_page_indicator.dart';

class CarouselArrowsNavbar extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final Color arrowBtnsColor;
  final double iconSize;
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;
  final bool isNextActive;

  const CarouselArrowsNavbar({
    Key? key,
    required this.currentPage,
    required this.pageCount,
    required this.arrowBtnsColor,
    required this.iconSize,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.isNextActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArrowButton(
          direction: ArrowDirection.left,
          containerColor: arrowBtnsColor,
          iconSize: iconSize,
          onPressed: onBackPressed,
          active: currentPage != 0,
        ),
        PageIndicator(
          currentPage: currentPage,
          pageCount: pageCount,
        ),
        ArrowButton(
          direction: ArrowDirection.right,
          containerColor: arrowBtnsColor,
          iconSize: iconSize,
          onPressed: onNextPressed,
          active: isNextActive,
        ),
      ],
    );
  }
}
