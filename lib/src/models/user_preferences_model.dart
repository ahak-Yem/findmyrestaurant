import 'package:findmyrestaurant/src/enums/survey_questions_enum.dart';
import 'package:hive/hive.dart';

part 'user_preferences_model.g.dart';

@HiveType(typeId: 1)
class UserPreferencesModel {
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

  UserPreferencesModel({
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

  void setPreferencesField(String questionId, dynamic value) {
    if (questionId == SurveyQuestions.dietaryRestrictions.id && value is List<String>) {
      _dietaryRestrictions = value;
    } else if (questionId == SurveyQuestions.allergies.id && value is List<String>) {
      _allergies = value;
    } else if (questionId == SurveyQuestions.cuisinePreferences.id && value is List<String>) {
      _cuisinePreferences = value;
    } else if (questionId == SurveyQuestions.mealPreferences.id && value is List<String>) {
      _mealPreferences = value;
    } else if (questionId == SurveyQuestions.favoriteIngredients.id && value is String) {
      _favoriteIngredients = value;
    } else if (questionId == SurveyQuestions.dislikedIngredients.id && value is String) {
      _dislikedIngredients = value;
    } else if (questionId == SurveyQuestions.mealsPerDay.id && int.tryParse(value) is int) {
      _mealsPerDay = int.tryParse(value);
    } else if (questionId == SurveyQuestions.eatingHabits.id && value is String) {
      _eatingHabits = value;
    }
  }

  Map<String, dynamic> generateIdOptionsMap() {
    final Map<String, dynamic> savedOptionsMap = {};
    for (final question in SurveyQuestions.values) {
      switch (question) {
        case SurveyQuestions.dietaryRestrictions:
          savedOptionsMap[question.id] = dietaryRestrictions ?? [];
          break;
        case SurveyQuestions.allergies:
          savedOptionsMap[question.id] = allergies ?? [];
          break;
        case SurveyQuestions.cuisinePreferences:
          savedOptionsMap[question.id] = cuisinePreferences ?? [];
          break;
        case SurveyQuestions.mealPreferences:
          savedOptionsMap[question.id] = mealPreferences ?? [];
          break;
        case SurveyQuestions.favoriteIngredients:
          savedOptionsMap[question.id] = favoriteIngredients ?? '';
          break;
        case SurveyQuestions.dislikedIngredients:
          savedOptionsMap[question.id] = dislikedIngredients ?? '';
          break;
        case SurveyQuestions.mealsPerDay:
          savedOptionsMap[question.id] = mealsPerDay ?? 0;
          break;
        case SurveyQuestions.eatingHabits:
          savedOptionsMap[question.id] = eatingHabits ?? '';
          break;
      }
    }
    return savedOptionsMap;
  }
}
