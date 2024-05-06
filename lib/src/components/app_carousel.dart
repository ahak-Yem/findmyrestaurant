import 'package:findmyrestaurant/src/components/dot_page_indicator.dart';
import 'package:findmyrestaurant/src/items/app_carousel_item.dart';
import 'package:flutter/material.dart';

class AppCarousel extends StatefulWidget {
  final List<AppCarouselItem> items;
  final PageController pageController;
  final double heightPercentage;
  final Function(int) onPageChanged;

  const AppCarousel({
    Key? key,
    required this.items,
    required this.pageController,
    required this.heightPercentage,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * widget.heightPercentage / 100,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              widget.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return widget.items[index];
            },
          ),
        ),
        PageIndicator(
          currentPage: _currentIndex,
          pageCount: widget.items.length,
        ),
      ],
    );
  }
}
