import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class NumericQuestion extends StatelessWidget {
  final DietarySurveyQuestionsModel question;
  final int? answer;

  const NumericQuestion({
    super.key,
    required this.question,
    this.answer,
  });
  
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
            labelText: AppStrings.numericQuestionLabelText,
          ),
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            
          },
        ),
      ],
    );
  }
}