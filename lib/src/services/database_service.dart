import 'package:findmyrestaurant/src/enums/database%20enums/user_model_keys_enum.dart';
import 'package:findmyrestaurant/src/models/user_preferences_model.dart';
import 'package:findmyrestaurant/src/models/user_model.dart';
import 'package:findmyrestaurant/src/services/app_launch_service.dart';
import 'package:findmyrestaurant/src/services/device_info_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../enums/database%20enums/database_models_enum.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  static DatabaseService get instance => _instance;

  DatabaseService._internal();

  final DatabaseModelsEnum _userDatabaseModelEnum = DatabaseModelsEnum.user;
  final DeviceInfoService deviceInfoService = DeviceInfoService.instance;

  Future<void> initialize() async {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserPreferencesModelAdapter());
    await Hive.initFlutter();
    String userId = await deviceInfoService.deviceID;
    _saveUserID(userId);
  }

  void _saveUserID(String userId) async{
    if(await readUserID() == userId){
      return;
    }
    Box userBox = await _userDatabaseModelEnum.box;
    String key = UserModelKeysEnum.id.key;
    if (userBox.get(key) == null) {
      userBox.put(key, userId);
    }
    userBox.close();
  }

  Future<String?> readUserID() async{
    Box userBox = await _userDatabaseModelEnum.box;
    String key = UserModelKeysEnum.id.key;
    return userBox.get(key);
  }

  Future<void> save<T>(DatabaseModelsEnum databaseModelType, dynamic key, T value) async {
    final box = await databaseModelType.box;
    if (databaseModelType.isSingleton && box.get(key) != null) {
      await delete(databaseModelType, key);
    }
    await box.put(key, value);
    box.close();

    updateAppLaunchServiceProperties(databaseModelType, value);
  }

  Future<void> delete(DatabaseModelsEnum databaseModelType, dynamic key) async {
    final box = await databaseModelType.box;
    await box.delete(key);
    box.close();
  }

  Future<T?> read<T>(DatabaseModelsEnum databaseModelType, dynamic key) async {
    final box = await databaseModelType.box;
    return box.get(key);
  }

  void updateAppLaunchServiceProperties<T>(DatabaseModelsEnum databaseModelType, T propertyValue) {
    if (databaseModelType == DatabaseModelsEnum.user || databaseModelType == DatabaseModelsEnum.dietaryUserPreferences) {
      AppLaunchService.instance.refreshProperties(propertyValue);
    }
  }
}
