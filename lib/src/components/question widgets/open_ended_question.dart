import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class OpenEndedQuestion extends StatelessWidget {
  final DietarySurveyQuestionsModel question;
  final Function(String) onNext;
  final String? answer;

  const OpenEndedQuestion({
    Key? key,
    required this.question,
    required this.onNext,
    this.answer,
  }) : super(key: key);

  TextEditingController init() {
    TextEditingController controller = TextEditingController();
    if (answer != null) {
      controller.text = answer.toString();
    }
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = init();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: AppStrings.openEndedQuestionLabelText,
          ),
        ),
        const SizedBox(height: 16),
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.goNextBtn,
          onPressed: () {
            onNext(controller.text.trim());
          },
        ),
      ],
    );
  }
}
