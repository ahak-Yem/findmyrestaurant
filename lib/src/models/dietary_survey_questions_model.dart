import 'package:findmyrestaurant/src/enums/survey_question_type_enum.dart';

class DietarySurveyQuestionsModel {
  final String id;
  final String question;
  final SurveyQuestionType type;
  final List<String>? options;
  final String? otherOptionLabel; 

  DietarySurveyQuestionsModel({
    required this.id,
    required this.question,
    required this.type,
    this.options,
    this.otherOptionLabel,
  });
}
