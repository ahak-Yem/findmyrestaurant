import 'package:findmyrestaurant/app%20string/app_strings.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/items/app_carousel_item.dart';
import 'package:findmyrestaurant/app styles/app_colors.dart';

enum OnboardingPages {
  intro(
    pageIndex: 0
  ),
  secondTestView(
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
                _carouselController?.animateToPage(pageIndex + 1);
              }
            )
          ],
        );
      case OnboardingPages.secondTestView: 
        return AppCarouselItem(
          headerText: "Second Test View Header",
          subText: "This is the second test view subtext.",
          buttons: [
            AppDynamicButton(
              color: AppColors.primaryColor,
              textColor: AppColors.appWhite,
              text: "Continue",
              onPressed: () {
                _carouselController?.animateToPage(pageIndex + 1);
              }
            )
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
        return OnboardingPages.secondTestView.page;
      default:
        return emptyItem;
    }
  }
}
