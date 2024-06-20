import 'package:findmyrestaurant/src/enums/database%20enums/database_models_enum.dart';
import 'package:findmyrestaurant/src/models/user_model.dart';
import 'package:findmyrestaurant/src/models/user_preferences_model.dart';
import 'package:findmyrestaurant/src/services/database_service.dart';
import 'package:flutter/foundation.dart';

// TODO: Add logic to not repeat survey and add preferences instances
class AppLaunchService {
  static final AppLaunchService _instance = AppLaunchService._internal();

  static AppLaunchService get instance => _instance;

  factory AppLaunchService() => _instance;

  AppLaunchService._internal();
  
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _userId;
  String? get userId => _userId;

  UserModel? _user;
  UserModel? get user => _user;

  bool _isUserSaved = false;
  bool get isUserSaved => _isUserSaved;

  UserPreferencesModel? _userPreferences;
  UserPreferencesModel? get userPreferences => _userPreferences;

  bool _isUserEmailConfirmed = false;
  bool get isUserEmailConfirmed => _isUserEmailConfirmed;

  bool _isSurveyCompleted = false;
  bool get isSurveyCompleted => _isSurveyCompleted;

  Future<void> initialize() async {
    try {
      _userId = await _databaseService.readUserID();
      if (_userId != null) {
        _user = await _databaseService.read(DatabaseModelsEnum.user, _userId);
        _isUserSaved = _user?.email.isNotEmpty ?? false;
        _isUserEmailConfirmed = _user?.isEmailConfirmed ?? false;
        _userPreferences = await _databaseService.read(DatabaseModelsEnum.dietaryUserPreferences, _userId);
        if (_userPreferences != null && _userPreferences?.eatingHabits != null) {
          _isSurveyCompleted = _userPreferences?.eatingHabits! != "";
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize AppLaunchService: $e');
      }
    }
  }
}
