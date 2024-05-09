import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SignupPage {
  SignupPage._();

  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController confirmPasswordController = TextEditingController();

  static AppCarouselItem get page {
    return AppCarouselItem(
      page: OnboardingPages.signUp,
      headerText: AppStrings.signupHeader,
      subText: AppStrings.signupSubtext,
      textFields: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: AppStrings.nameFieldLabel,
          ),
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: AppStrings.emailFieldLabel,
          ),
        ),
        TextField(
            controller: passwordController,
          decoration: const InputDecoration(
            labelText: AppStrings.passwordFieldLabel,
          ),
          obscureText: true,
        ),
        TextField(
          controller: confirmPasswordController,
          decoration: const InputDecoration(
            labelText: AppStrings.confirmPasswordFieldLabel,
          ),
          obscureText: true,
        ),
      ],
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.signupBtn,
          onPressed: () {
            final String name = nameController.text;
            final String email = emailController.text;
            final String password = passwordController.text;
            final String confirmPassword = confirmPasswordController.text;
            OnboardingPagesExtension.carouselController?.handleSignup(name: name, email: email, password: password, confirmPassword: confirmPassword);
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
