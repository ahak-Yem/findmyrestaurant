import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/components/text%20fields/password_text_field.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/src/models/user_model.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SignupPage {
  SignupPage._();

  static final AppCarouselController? appCarouselController = OnboardingPagesExtension.carouselController;
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController confirmPasswordController = TextEditingController();

  static void setSavedUser(UserModel userModel) {
    nameController.text = userModel.name;
    emailController.text = userModel.email;
    passwordController.text = userModel.password;
    confirmPasswordController.text = userModel.password;
  }

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
        PasswordTextField(
          controller: passwordController,
          labelText: AppStrings.passwordFieldLabel,
        ),
        PasswordTextField(
          controller: confirmPasswordController,
          labelText: AppStrings.confirmPasswordFieldLabel,
        ),
      ],
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.signupBtn,
          onPressed: () {
            appCarouselController?.goNext(currentPage: OnboardingPages.signUp.pageIndex);
          },
        ),
        AppDynamicButton(
          color: AppColors.appWhite,
          textColor: AppColors.primaryColor,
          text: AppStrings.goBackBtn,
          onPressed: () {
            appCarouselController?.goBack(currentPage: OnboardingPages.signUp.pageIndex);
          },
        ),
      ],
    );
  }
}
