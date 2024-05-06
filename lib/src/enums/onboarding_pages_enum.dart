import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';

enum OnboardingPages {
  intro(
    pageIndex: 0
  ),
  getStarted(
    pageIndex: 1
  );

  const OnboardingPages({required this.pageIndex});

  final int pageIndex;
}

extension OnboardingPagesExtension on OnboardingPages {  
  static AppCarouselController? _carouselController;
  static AppCarouselController? get  carouselController => _carouselController;

  static void setAppCarouselController(AppCarouselController controller) {
    _carouselController = controller;
  }

  AppCarouselItem get page {
    switch(this) {
      case OnboardingPages.intro: 
        return AppCarouselItem(
          headerText: AppStrings.welcomeMessage,
          subText: AppStrings.welcomeSubMessage,
          buttons: [
            AppDynamicButton(
              color: AppColors.primaryColor,
              textColor: AppColors.appWhite,
              text: AppStrings.getStartedBtn,
              onPressed: () {
                _carouselController?.goNext(pageIndex);
              }
            ),
          ],
        );
      case OnboardingPages.getStarted: 
        return AppCarouselItem(
          headerText: AppStrings.signupHeader,
          subText: AppStrings.signupText,
          buttons: [
            AppDynamicButton(
              color: AppColors.primaryColor,
              textColor: AppColors.appWhite,
              text: AppStrings.signupBtn,
              onPressed: () {
                _carouselController?.goNext(pageIndex);
              }
            ),
            AppDynamicButton(
              color: AppColors.appWhite,
              textColor: AppColors.primaryColor,
              text: AppStrings.goBackBtn,
              onPressed: () {
                _carouselController?.goBack(pageIndex);
              }
            ),
          ],
        );
    }
  }

  static AppCarouselItem getPageByIndex(int index) {
    AppCarouselItem emptyItem = const AppCarouselItem(
      headerText: "",
      subText: "",
    );
    if (!OnboardingPages.values.any((page) => page.pageIndex == index)) {
      return emptyItem;
    }
    switch(index) {
      case 0:
        return OnboardingPages.intro.page;
      case 1:
        return OnboardingPages.getStarted.page;
      default:
        return emptyItem;
    }
  }
}
