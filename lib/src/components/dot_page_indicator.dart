import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final Color activeDotColor;
  final Color inactiveDotColor;

  const PageIndicator({
    Key? key,
    required this.currentPage,
    required this.pageCount,
    this.activeDotColor = AppColors.darkGray,
    this.inactiveDotColor = AppColors.gray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? activeDotColor : inactiveDotColor,
          ),
        );
      }),
    );
  }
}
