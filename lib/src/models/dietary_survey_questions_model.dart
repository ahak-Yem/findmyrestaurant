import 'package:findmyrestaurant/src/enums/survey_question_type_enum.dart';

class DietarySurveyQuestionsModel {
  final String id;
  final String question;
  final SurveyQuestionType type;
  final List<String>? options;
  final Map<String, String>? images;

  DietarySurveyQuestionsModel({
    required this.id,
    required this.question,
    required this.type,
    this.options,
    this.images
  });

  static DietarySurveyQuestionsModel fromJson(Map<String, dynamic> json) {
    return DietarySurveyQuestionsModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      type: SurveyQuestionType.values.firstWhere((e) => e.name == json['type'], orElse: () => SurveyQuestionType.openEnded,),
      options: json['options'] != null ? List<String>.from(json['options']) : null,
      images: json['images'] != null ? Map<String, String>.from(json['images']) : null,
    );
  }
}
