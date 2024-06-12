import 'package:hive/hive.dart';

part 'dietary_survey_user_preferences_model.g.dart';

@HiveType(typeId: 1)
class DietarySurveyUserPreferencesModel {
  @HiveField(0)
  List<String>? dietaryRestrictions;
  
  @HiveField(1)
  List<String>? allergies;
  
  @HiveField(2)
  List<String>? cuisinePreferences;
  
  @HiveField(3)
  List<String>? mealPreferences;
  
  @HiveField(4)
  String? favoriteIngredients;
  
  @HiveField(5)
  String? dislikedIngredients;
  
  @HiveField(6)
  int? mealsPerDay;
  
  @HiveField(7)
  String? eatingHabits;

  DietarySurveyUserPreferencesModel({
    this.dietaryRestrictions,
    this.allergies,
    this.cuisinePreferences,
    this.mealPreferences,
    this.favoriteIngredients,
    this.dislikedIngredients,
    this.mealsPerDay,
    this.eatingHabits,
  });
}
