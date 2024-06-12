class DietarySurveyUserPreferencesModel {
  List<String> dietaryRestrictions;
  List<String> allergies;
  List<String> cuisinePreferences;
  List<String> mealPreferences;
  String favoriteIngredients;
  String dislikedIngredients;
  int mealsPerDay;
  String eatingHabits;

  DietarySurveyUserPreferencesModel({
    required this.dietaryRestrictions,
    required this.allergies,
    required this.cuisinePreferences,
    required this.mealPreferences,
    required this.favoriteIngredients,
    required this.dislikedIngredients,
    required this.mealsPerDay,
    required this.eatingHabits,
  });
}
