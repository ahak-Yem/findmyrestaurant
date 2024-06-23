import 'package:flutter/material.dart';

class AppCarousel extends StatefulWidget {
  final List<Widget> items;
  final PageController pageController;
  final double heightPercentage;
  final EdgeInsets indicatorPadding; 
  final Function(int) onPageChanged;
  final bool isNotScrollable;
  final Widget bottomBar;
  final Color? bottomBarColor;

  const AppCarousel({
    Key? key,
    required this.items,
    required this.pageController,
    required this.heightPercentage,
    required this.indicatorPadding,
    required this.onPageChanged,
    required this.isNotScrollable,
    required this.bottomBar,
    this.bottomBarColor,
  }) : super(key: key);

  @override
  createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 34),
          height: MediaQuery.of(context).size.height * widget.heightPercentage / 100,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.items.length,
            physics: widget.isNotScrollable ? const NeverScrollableScrollPhysics() : null,
            onPageChanged: (index) {
              widget.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return widget.items[index];
            },
          ),
        ),
        Container(
          color: widget.bottomBarColor,
          padding: widget.indicatorPadding,
          child: widget.bottomBar,
        ),
      ],
    );
  }
}
