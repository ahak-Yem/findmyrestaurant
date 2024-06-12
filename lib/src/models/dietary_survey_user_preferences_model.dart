import 'package:hive/hive.dart';

part 'dietary_survey_user_preferences_model.g.dart';

@HiveType(typeId: 1)
class DietarySurveyUserPreferencesModel {
  @HiveField(0)
  List<String>? _dietaryRestrictions;
  List<String>? get dietaryRestrictions => _dietaryRestrictions;

  @HiveField(1)
  List<String>? _allergies;
  List<String>? get allergies => _allergies;

  @HiveField(2)
  List<String>? _cuisinePreferences;
  List<String>? get cuisinePreferences => _cuisinePreferences;

  @HiveField(3)
  List<String>? _mealPreferences;
  List<String>? get mealPreferences => _mealPreferences;

  @HiveField(4)
  String? _favoriteIngredients;
  String? get favoriteIngredients => _favoriteIngredients;

  @HiveField(5)
  String? _dislikedIngredients;
  String? get dislikedIngredients => _dislikedIngredients;

  @HiveField(6)
  int? _mealsPerDay;
  int? get mealsPerDay => _mealsPerDay;

  @HiveField(7)
  String? _eatingHabits;
  String? get eatingHabits => _eatingHabits;

  DietarySurveyUserPreferencesModel({
    List<String>? dietaryRestrictions,
    List<String>? allergies,
    List<String>? cuisinePreferences,
    List<String>? mealPreferences,
    String? favoriteIngredients,
    String? dislikedIngredients,
    int? mealsPerDay,
    String? eatingHabits,
  }) 
  : _eatingHabits = eatingHabits, 
  _mealsPerDay = mealsPerDay, 
  _dislikedIngredients = dislikedIngredients, 
  _favoriteIngredients = favoriteIngredients, 
  _mealPreferences = mealPreferences, 
  _cuisinePreferences = cuisinePreferences, 
  _allergies = allergies, 
  _dietaryRestrictions = dietaryRestrictions;
}
