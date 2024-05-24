import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';

class CompleteOnboardingPage {
  CompleteOnboardingPage._();

  static AppCarouselItem get page {
    return AppCarouselItem(
      page: OnboardingPages.completeOnboarding,
      headerText: AppStrings.completeSignupHeader,
      subText: 
      '''
        ${AppStrings.confirmationEmailSubtext}
        
        ${AppStrings.completeSignupConfirmationMsg}
      ''' ,
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.toSurveyBtn,
          onPressed: () {
            //TODO:Build logic to end signup process and navigate to survey.
          },
        ),
      ],
    );
  }
}
