import 'package:findmyrestaurant/app%20string/app_strings.dart';
import 'package:findmyrestaurant/src/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/items/app_carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/app styles/app_colors.dart';

enum OnboardingPages {
  intro(
    pageIndex: 0
  );

  const OnboardingPages({required this.pageIndex});

  final int pageIndex;
}

extension OnboardingPagesExtension on OnboardingPages{
  static final AppCarouselController<int> _carouselController = AppCarouselController<int>();

  Widget get page{
    switch(this){
      case OnboardingPages.intro: 
      return AppCarouselItem(
        headerText: AppStrings.welcomeMessage,
        subText: AppStrings.welcomeSubMessage,
        buttons: [
          AppDynamicButton(
            color: AppColors.primaryColor,
            textColor: AppColors.appWhite,
            text: AppStrings.getStartedBtn,
            onPressed: (){
              _carouselController.animateToPage(pageIndex + 1);
            }
          )
        ],
      );
    }
  }

  static Widget getPageByIndex(int index) {
    if (OnboardingPages.values.any((page) => page.pageIndex != index)) {
      return Container();
    }
    switch(index) {
      case 0:
        return OnboardingPages.intro.page;
      default:
        return Container();
    }
  }
}