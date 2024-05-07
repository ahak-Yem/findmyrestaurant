import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';

class IntroPage {
  IntroPage._();

  static AppCarouselItem get page {
    return AppCarouselItem(
      headerText: AppStrings.welcomeMessage,
      subText: AppStrings.welcomeSubMessage,
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.getStartedBtn,
          onPressed: () {
            OnboardingPagesExtension.carouselController?.goNext(currentPage: OnboardingPages.intro.pageIndex);
          },
        ),
      ],
    );
  }
}
