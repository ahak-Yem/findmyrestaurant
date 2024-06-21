import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class NumericQuestion extends StatelessWidget {
  final DietarySurveyQuestionsModel question;
  final Function(int?) onNext;
  final int? answer;

  const NumericQuestion({
    super.key,
    required this.question,
    required this.onNext,
    this.answer,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: AppStrings.numericQuestionLabelText,
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        AppDynamicButton(
          color: AppColors.primaryColor,
          textColor: AppColors.appWhite,
          text: AppStrings.goNextBtn,
          onPressed: () {
            onNext(int.tryParse(controller.text.trim()));
          },
        ),
      ],
    );
  }
}