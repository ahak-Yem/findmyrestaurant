import 'package:findmyrestaurant/src/enums/survey_question_type_enum.dart';

class DietarySurveyQuestionsModel {
  final String id;
  final String question;
  final SurveyQuestionType type;
  final List<String>? options;

  DietarySurveyQuestionsModel({
    required this.id,
    required this.question,
    required this.type,
    this.options,
  });

  static DietarySurveyQuestionsModel fromJson(Map<String, dynamic> json) {
    return DietarySurveyQuestionsModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      type: SurveyQuestionType.values.firstWhere((e) => e.name == json['type'] || e.name == SurveyQuestionType.multipleChoice.name),
      options: json['options'] != null ? List<String>.from(json['options']) : null,
    );
  }
}
