import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/components/text%20fields/code_boxes_text_field.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/src/services/email_service.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

//TODO: Add code expiration timmer 
class ConfirmEmailPage {
  ConfirmEmailPage._();

  static final AppCarouselController? appCarouselController = OnboardingPagesExtension.carouselController;
  static final TextEditingController confirmationCodeController = TextEditingController();
  static List<String> textCharacters = List.filled(6, '');
  static final EmailService emailService = EmailService.instance;

  static void _handleBoxValueChange(int index, int boxesAmount, String value) {
     if (index < textCharacters.length && index < boxesAmount) {
      textCharacters[index] = value;
    }
    confirmationCodeController.text = textCharacters.join();
    if(confirmationCodeController.text.length == boxesAmount) {
      appCarouselController?.goNext(currentPage: OnboardingPages.confirmEmail.pageIndex);
    }
  }

  static AppCarouselItem get page {
    const boxesAmount = 6;
    return AppCarouselItem(
      page: OnboardingPages.confirmEmail,
      headerText: AppStrings.confirmationEmailHeader,
      subText: AppStrings.confirmationEmailSubtext,
      textFields: [
        CodeBoxesTextField(
          onChanged: (value, index) => _handleBoxValueChange(index, boxesAmount, value),
          boxesAmount: boxesAmount,
        ),
      ],
      buttons: [
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.resendCodeBtn,
          onPressed: () async {
            await emailService.sendAnotherConfirmationEmail();
          },
        ),
        AppDynamicButton(
          color: AppColors.appWhite,
          textColor: AppColors.primaryColor,
          text: AppStrings.goBackBtn,
          onPressed: () {
            appCarouselController?.goBack(currentPage: OnboardingPages.confirmEmail.pageIndex);
          },
        ),
      ],
    );
  }
}
