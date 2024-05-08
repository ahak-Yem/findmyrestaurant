import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SignupPage {
  SignupPage._();

  static AppCarouselItem get page {
    return AppCarouselItem(
      page: OnboardingPages.signUp,
      headerText: AppStrings.signupHeader,
      subText: AppStrings.signupSubtext,
      textFields: const [
        TextField(
          decoration: InputDecoration(
            labelText: AppStrings.nameFieldLabel,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: AppStrings.emailFieldLabel,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: AppStrings.passwordFieldLabel,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: AppStrings.confirmPasswordFieldLabel,
          ),
        ),
      ],
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.signupBtn,
          onPressed: () {
            OnboardingPagesExtension.carouselController?.goNext(currentPage: OnboardingPages.signUp.pageIndex);
          },
        ),
        AppDynamicButton(
          color: AppColors.appWhite,
          textColor: AppColors.primaryColor,
          text: AppStrings.goBackBtn,
          onPressed: () {
            OnboardingPagesExtension.carouselController?.goBack(currentPage: OnboardingPages.signUp.pageIndex);
          },
        ),
      ],
    );
  }
}
