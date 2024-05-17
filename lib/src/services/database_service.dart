import 'package:findmyrestaurant/src/enums/user_model_keys_enum.dart';
import 'package:findmyrestaurant/src/models/user_model.dart';
import 'package:findmyrestaurant/src/services/device%20info/device_info_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../enums/database_models_enum.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  static DatabaseService get instance => _instance;

  DatabaseService._internal();

  final DatabaseModelsEnum _userDatabaseModelEnum = DatabaseModelsEnum.user;

  Future<void> initialize() async {
    DeviceInfoService deviceInfoService = DeviceInfoService.instance;
    Hive.registerAdapter(UserModelAdapter());
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
  }

  Future<String?> readUserID() async{
    Box userBox = await _userDatabaseModelEnum.box;
    String key = UserModelKeysEnum.id.key;
    return userBox.get(key);
  }

  Future<void> save<T>(DatabaseModelsEnum model, dynamic key, T value) async {
    final box = await model.box;
    if(model.isSingleton && box.get(key) != null){
      delete(model, key);
    }
    box.put(key, value);
  }

  Future<void> delete(DatabaseModelsEnum model, dynamic key) async {
    final box = await model.box;
    box.delete(key);
  }

  Future<T?> read<T>(DatabaseModelsEnum model, dynamic key) async {
    final box = await model.box;
    return box.get(key);
  }
}