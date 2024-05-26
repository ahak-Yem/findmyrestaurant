import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/components/app_timer.dart';
import 'package:findmyrestaurant/src/components/text%20fields/code_boxes_text_field.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/src/services/confirmation_code_service.dart';
import 'package:findmyrestaurant/src/services/email_service.dart';
import 'package:findmyrestaurant/src/services/timer_service.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmEmailPage {
  ConfirmEmailPage._();
  
  static bool canResend = true;
  static List<String> textCharacters = List.filled(6, '');

  static final AppCarouselController? appCarouselController = OnboardingPagesExtension.carouselController;
  static final TextEditingController confirmationCodeController = TextEditingController();
  
  static final EmailService emailService = EmailService.instance;
  static final ConfirmationCodeService codeService = ConfirmationCodeService.instance;
  
  static final TimerService codeTimer = TimerService();
  static final TimerService resendTimer = TimerService();

  static void _handleBoxValueChange(int index, int boxesAmount, String value) {
    if (index < textCharacters.length && index < boxesAmount) {
      textCharacters[index] = value;
    }
    confirmationCodeController.text = textCharacters.join();
    if (confirmationCodeController.text.length == boxesAmount) {
      appCarouselController?.goNext(currentPage: OnboardingPages.confirmEmail.pageIndex);
    }
  }

  static void resetCodeTimer() {
    codeTimer.resetTimer();
  }

  static void resetResendTimer() {
    resendTimer.resetTimer();
  }

  static void emptyConfirmationCodeController() {
    confirmationCodeController.text = '';
    textCharacters = List.filled(6, '');
  }

  static AppCarouselItem get page {
    const boxesAmount = 6;
    codeTimer.startTimer(seconds: codeService.codeValidityDuration.inSeconds);

    return AppCarouselItem(
      page: OnboardingPages.confirmEmail,
      headerText: AppStrings.confirmationEmailHeader,
      subText: AppStrings.confirmationEmailSubtext,
      textFields: [
        CodeBoxesTextField(
          onChanged: (value, index) => _handleBoxValueChange(index, boxesAmount, value),
          boxesAmount: boxesAmount,
        ),
        ChangeNotifierProvider<TimerService>.value(
          value: codeTimer,
          child: const TimerWidget(
            text: AppStrings.codeExpiresInLabel, 
            textColor: AppColors.red,
          ),
        ),
      ],
      buttons: [
        ChangeNotifierProvider<TimerService>.value(
          value: resendTimer,
          child:  AppDynamicButton(
            color: canResend ? AppColors.primaryColor : AppColors.disabledBtnColor,
            textColor: AppColors.appWhite,
            text: canResend ? 
              AppStrings.resendCodeBtn 
              : TimerWidget(
                text: AppStrings.resendIn, 
                textColor: AppColors.appWhite,
                onTimerFinished: () {
                  canResend = true;
                },
              ).text,
            onPressed: () async {
              if(canResend){
                canResend = false;
                await emailService.sendAnotherConfirmationEmail();
                resetCodeTimer();
              }
            },
          ),
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
