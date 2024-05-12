import 'package:findmyrestaurant/src/components/app buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';

class ExtraPage {
  ExtraPage._();

  static AppCarouselItem get page {
    return AppCarouselItem(
      page: OnboardingPages.extra,
      headerText: 'Extra Page Header',
      subText: 'This is an extra page for testing.',
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: "Go next",
          onPressed: () {
            OnboardingPagesExtension.carouselController?.goNext(currentPage: OnboardingPages.extra.pageIndex);
          },
        ),
        AppDynamicButton(
          color: AppColors.appWhite,
          textColor: AppColors.primaryColor,
          text: AppStrings.goBackBtn,
          onPressed: () {
            OnboardingPagesExtension.carouselController?.goBack(currentPage: OnboardingPages.extra.pageIndex);
          },
        ),
      ],
    );
  }
}
