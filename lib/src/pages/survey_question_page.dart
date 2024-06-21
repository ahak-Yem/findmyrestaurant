import 'package:findmyrestaurant/src/enums/survey_question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class SurveyQuestionPage extends StatelessWidget {
  final DietarySurveyQuestionsModel question;
  final Function(dynamic) onNext;
  final dynamic answer;

  const SurveyQuestionPage({
    super.key,
    required this.question,
    required this.onNext,
    this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 38.0),
          Text(
            question.question,
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          question.type.buildWidget(question, onNext, answer),
        ],
      ),
    );
  }
}
