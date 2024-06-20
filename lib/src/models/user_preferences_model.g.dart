// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPreferencesModelAdapter extends TypeAdapter<UserPreferencesModel> {
  @override
  final int typeId = 1;

  @override
  UserPreferencesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreferencesModel()
      .._dietaryRestrictions = (fields[0] as List?)?.cast<String>()
      .._allergies = (fields[1] as List?)?.cast<String>()
      .._cuisinePreferences = (fields[2] as List?)?.cast<String>()
      .._mealPreferences = (fields[3] as List?)?.cast<String>()
      .._favoriteIngredients = fields[4] as String?
      .._dislikedIngredients = fields[5] as String?
      .._mealsPerDay = fields[6] as int?
      .._eatingHabits = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, UserPreferencesModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj._dietaryRestrictions)
      ..writeByte(1)
      ..write(obj._allergies)
      ..writeByte(2)
      ..write(obj._cuisinePreferences)
      ..writeByte(3)
      ..write(obj._mealPreferences)
      ..writeByte(4)
      ..write(obj._favoriteIngredients)
      ..writeByte(5)
      ..write(obj._dislikedIngredients)
      ..writeByte(6)
      ..write(obj._mealsPerDay)
      ..writeByte(7)
      ..write(obj._eatingHabits);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferencesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
