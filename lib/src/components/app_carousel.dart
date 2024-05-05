import 'package:findmyrestaurant/src/components/dot_page_indicator.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
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
  void initState() {
    super.initState();
    if(OnboardingPagesExtension.carouselController == null && widget.pageController is AppCarouselController){
      OnboardingPagesExtension.setAppCarouselController(widget.pageController as AppCarouselController);
    }
  }

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
              return Column(
                children: [
                  widget.items[index],
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  PageIndicator(
                    currentPage: _currentIndex,
                    pageCount: widget.items.length,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
