enum DietarySurveyUserPreferencesKeysEnum {
  dietaryRestrictions,
  allergies,
  cuisinePreferences,
  mealPreferences,
  favoriteIngredients,
  dislikedIngredients,
  mealsPerDay,
  eatingHabits,
}

extension DietarySurveyUserPreferencesKeysEnumExtension on DietarySurveyUserPreferencesKeysEnum {
  String get key {
    switch (this) {
      case DietarySurveyUserPreferencesKeysEnum.dietaryRestrictions:
        return "dietaryRestrictions";
      case DietarySurveyUserPreferencesKeysEnum.allergies:
        return "allergies";
      case DietarySurveyUserPreferencesKeysEnum.cuisinePreferences:
        return "cuisinePreferences";
      case DietarySurveyUserPreferencesKeysEnum.mealPreferences:
        return "mealPreferences";
      case DietarySurveyUserPreferencesKeysEnum.favoriteIngredients:
        return "favoriteIngredients";
      case DietarySurveyUserPreferencesKeysEnum.dislikedIngredients:
        return "dislikedIngredients";
      case DietarySurveyUserPreferencesKeysEnum.mealsPerDay:
        return "mealsPerDay";
      case DietarySurveyUserPreferencesKeysEnum.eatingHabits:
        return "eatingHabits";
    }
  }
}
