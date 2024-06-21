import 'package:findmyrestaurant/src/components/question%20widgets/multiple_choice_question.dart';
import 'package:findmyrestaurant/src/components/question%20widgets/numeric_question.dart';
import 'package:findmyrestaurant/src/components/question%20widgets/open_ended_question.dart';
import 'package:findmyrestaurant/src/components/question%20widgets/single_choice_question.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';
import 'package:flutter/material.dart';

enum SurveyQuestionType {
  multipleChoice,
  openEnded,
  numeric,
  singleChoice,
}

extension SurveyQuestionTypeExtension on SurveyQuestionType {
  String get typeString {
    switch (this) {
      case SurveyQuestionType.multipleChoice:
        return "multipleChoice";
      case SurveyQuestionType.openEnded:
        return "openEnded";
      case SurveyQuestionType.numeric:
        return "numeric";
      case SurveyQuestionType.singleChoice:
        return "singleChoice";
    }
  }

  // TODO: Disable onNext until an option is selected
  Widget buildWidget(DietarySurveyQuestionsModel question, Function(dynamic) onNext, dynamic answer) {
    switch (this) {
      case SurveyQuestionType.multipleChoice:
        return MultipleChoiceQuestion(
          question: question,
          onNext: onNext,
          savedOptions: answer is List<String> ? answer : null,
        );
      case SurveyQuestionType.singleChoice:
        return SingleChoiceQuestion(
          question: question,
          onNext: onNext,
          savedOption: answer is String ? answer : null,
        );
      case SurveyQuestionType.openEnded:
        return OpenEndedQuestion(
          question: question,
          onNext: onNext,
          answer: answer is String ? answer : null,
        );
      case SurveyQuestionType.numeric:
        return NumericQuestion(
          question: question,
          onNext: onNext,
          answer: answer is int ? answer : null,
        );
      default:
        return Container();
    }
  }
}
