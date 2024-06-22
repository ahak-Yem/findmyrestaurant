import 'package:findmyrestaurant/src/enums/survey_question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class SurveyQuestionItem extends StatelessWidget {
  final DietarySurveyQuestionsModel question;
  final dynamic answer;

  const SurveyQuestionItem({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question.question,
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          question.type.buildWidget(question, answer),
        ],
      ),
    );
  }
}
