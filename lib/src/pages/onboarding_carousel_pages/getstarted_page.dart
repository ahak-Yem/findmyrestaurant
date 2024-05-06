import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';

class GetstartedPage {
  GetstartedPage._();

  static AppCarouselItem get page {
    return AppCarouselItem(
      headerText: AppStrings.signupHeader,
      subText: AppStrings.signupText,
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.signupBtn,
          onPressed: () {
            OnboardingPagesExtension.carouselController?.goNext(OnboardingPages.getStarted.pageIndex);
          },
        ),
        AppDynamicButton(
          color: AppColors.appWhite,
          textColor: AppColors.primaryColor,
          text: AppStrings.goBackBtn,
          onPressed: () {
            OnboardingPagesExtension.carouselController?.goBack(OnboardingPages.getStarted.pageIndex);
          },
        ),
      ],
    );
  }
}