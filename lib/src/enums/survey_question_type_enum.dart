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
}
