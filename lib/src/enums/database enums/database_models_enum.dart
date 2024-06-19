// import 'package:findmyrestaurant/src/enums/database%20enums/dietary_survey_user_preferences_keys_enum.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'user_model_keys_enum.dart';

enum DatabaseModelsEnum {
  user,
  dietaryUserPreferences,
}

extension DatabaseModelsEnumExtension on DatabaseModelsEnum {
  String get boxName {
    switch (this) {
      case DatabaseModelsEnum.user:
        return 'userBox';
      case DatabaseModelsEnum.dietaryUserPreferences:
        return 'dietaryUserPreferencesBox';
      default:
        throw Exception('Invalid enum value');
    }
  }

  bool get isSingleton {
    switch (this) {
      case DatabaseModelsEnum.user:
        return true;
      case DatabaseModelsEnum.dietaryUserPreferences:
        return true;
      default:
        throw Exception('Invalid enum value');
    }
  }

  Future<Box<dynamic>> get box async {
    return await Hive.openBox(boxName);
  }

  // List<String> get keysEnum {
  //   switch (this) {
  //     case DatabaseModelsEnum.user:
  //       return [
  //         UserModelKeysEnum.id.key, 
  //         UserModelKeysEnum.name.key,
  //         UserModelKeysEnum.email.key,
  //         UserModelKeysEnum.profilePicture.key
  //       ].toList();
  //     case DatabaseModelsEnum.dietaryUserPreferences:
  //       return [
  //         DietarySurveyUserPreferencesKeysEnum.dietaryRestrictions.key,
  //         DietarySurveyUserPreferencesKeysEnum.allergies.key,
  //         DietarySurveyUserPreferencesKeysEnum.cuisinePreferences.key,
  //         DietarySurveyUserPreferencesKeysEnum.mealPreferences.key,
  //         DietarySurveyUserPreferencesKeysEnum.favoriteIngredients.key,
  //         DietarySurveyUserPreferencesKeysEnum.dislikedIngredients.key,
  //         DietarySurveyUserPreferencesKeysEnum.mealsPerDay.key,
  //         DietarySurveyUserPreferencesKeysEnum.eatingHabits.key
  //       ].toList();
  //     default:
  //       throw Exception('Invalid Enum Value!');
  //   }
  // }
}
