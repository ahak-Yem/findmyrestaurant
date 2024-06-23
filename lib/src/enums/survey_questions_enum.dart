enum SurveyQuestions {
  dietaryRestrictions,
  allergies,
  cuisinePreferences,
  mealPreferences,
  favoriteIngredients,
  dislikedIngredients,
  mealsPerDay,
  eatingHabits
}

extension SurveyQuestionsExtension on SurveyQuestions {
  String get id {
    switch (this) {
      case SurveyQuestions.dietaryRestrictions:
        return 'q1';
      case SurveyQuestions.allergies:
        return 'q2';
      case SurveyQuestions.cuisinePreferences:
        return 'q3';
      case SurveyQuestions.mealPreferences:
        return 'q4';
      case SurveyQuestions.favoriteIngredients:
        return 'q5';
      case SurveyQuestions.dislikedIngredients:
        return 'q6';
      case SurveyQuestions.mealsPerDay:
        return 'q7';
      case SurveyQuestions.eatingHabits:
        return 'q8';
    }
  }
}