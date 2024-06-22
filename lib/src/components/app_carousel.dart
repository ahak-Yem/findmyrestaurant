import 'package:findmyrestaurant/src/components/app%20buttons/arrow_button.dart';
import 'package:findmyrestaurant/src/components/dot_page_indicator.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppCarousel extends StatefulWidget {
  final List<Widget> items;
  final PageController pageController;
  final double heightPercentage;
  final EdgeInsets indicatorPadding; 
  final Function(int) onPageChanged;
  final bool isNotScrollable;
  final bool showArrows;
  final VoidCallback? onNext;
  final VoidCallback? onBack;

  const AppCarousel({
    Key? key,
    required this.items,
    required this.pageController,
    required this.heightPercentage,
    required this.indicatorPadding,
    required this.onPageChanged,
    required this.isNotScrollable,
    this.showArrows = false,
    this.onNext,
    this.onBack,
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
          padding: widget.indicatorPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.showArrows)...[
                ArrowButton(
                  direction: ArrowDirection.left,
                  containerColor: AppColors.primaryColor,
                  iconSize: 40,
                  onPressed: _currentIndex > 0 && widget.onBack != null ? widget.onBack! : (){},
                ),
              ],
              PageIndicator(
                currentPage: _currentIndex,
                pageCount: widget.items.length,
              ),
              if (widget.showArrows)...[
                ArrowButton(
                  direction: ArrowDirection.right,
                  containerColor: AppColors.primaryColor,
                  iconSize: 40,
                  onPressed: _currentIndex < widget.items.length - 1 && widget.onBack != null ? widget.onNext! : (){},
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
