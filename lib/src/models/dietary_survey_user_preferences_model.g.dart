// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dietary_survey_user_preferences_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DietarySurveyUserPreferencesModelAdapter
    extends TypeAdapter<DietarySurveyUserPreferencesModel> {
  @override
  final int typeId = 1;

  @override
  DietarySurveyUserPreferencesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DietarySurveyUserPreferencesModel(
      dietaryRestrictions: (fields[0] as List?)?.cast<String>(),
      allergies: (fields[1] as List?)?.cast<String>(),
      cuisinePreferences: (fields[2] as List?)?.cast<String>(),
      mealPreferences: (fields[3] as List?)?.cast<String>(),
      favoriteIngredients: fields[4] as String?,
      dislikedIngredients: fields[5] as String?,
      mealsPerDay: fields[6] as int?,
      eatingHabits: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DietarySurveyUserPreferencesModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.dietaryRestrictions)
      ..writeByte(1)
      ..write(obj.allergies)
      ..writeByte(2)
      ..write(obj.cuisinePreferences)
      ..writeByte(3)
      ..write(obj.mealPreferences)
      ..writeByte(4)
      ..write(obj.favoriteIngredients)
      ..writeByte(5)
      ..write(obj.dislikedIngredients)
      ..writeByte(6)
      ..write(obj.mealsPerDay)
      ..writeByte(7)
      ..write(obj.eatingHabits);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietarySurveyUserPreferencesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
