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
        headerText: 'Howdy & Welcome to Find my Restaurant App',
        subText: "Here you will find a brief overview of the app and how to use it's wonderful features.",
        buttons: [
          AppDynamicButton(
            color: AppColors.primaryColor,
            textColor: AppColors.appWhite,
            text: 'Get Started',
            onPressed: (){
              _carouselController.animateToPage(pageIndex + 1);
            }
          )
        ],
      );
    }
  }
}