import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';

class CompleteOnboardingPage {
  CompleteOnboardingPage._();

  static void Function()? _onSurveyButtonPressedCallback;
  
  static set onSurveyButtonPressedCallback(void Function()? callback) {
    _onSurveyButtonPressedCallback = callback;
  }

  static AppCarouselItem get page {
    return AppCarouselItem(
      page: OnboardingPages.completeOnboarding,
      headerText: AppStrings.completeSignupHeader,
      subText: 
      '''
        ${AppStrings.completeSignupSubtext}

        ${AppStrings.completeSignupConfirmationMsg}
      ''' ,
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.toSurveyBtn,
          onPressed: () {
            if (_onSurveyButtonPressedCallback != null) {
              _onSurveyButtonPressedCallback!();
            }
          },
        ),
      ],
    );
  }
}
