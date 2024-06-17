import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class OpenEndedQuestion extends StatelessWidget {
  final DietarySurveyQuestionsModel question;
  final Function(String) onNext;

  const OpenEndedQuestion({
    super.key,
    required this.question,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return TextField(
      controller: controller,
      decoration: const InputDecoration(labelText: AppStrings.openEndedQuestionLabelText),
      onSubmitted: (value) {
        onNext(value);
      },
    );
  }
}