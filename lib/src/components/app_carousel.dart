import 'package:findmyrestaurant/src/components/dot_page_indicator.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:flutter/material.dart';

class AppCarousel extends StatefulWidget {
  final List<AppCarouselItem> items;
  final PageController pageController;
  final double heightPercentage;
  final Function(int) onPageChanged;
  final bool isNotScrollable;

  const AppCarousel({
    Key? key,
    required this.items,
    required this.pageController,
    required this.heightPercentage,
    required this.onPageChanged,
    required this.isNotScrollable,
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
            physics: widget.isNotScrollable ? const NeverScrollableScrollPhysics() :  null,
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
        Container(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: PageIndicator(
            currentPage: _currentIndex,
            pageCount: widget.items.length,
          ),
        ),
      ],
    );
  }
}
