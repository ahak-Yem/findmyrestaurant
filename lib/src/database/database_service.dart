import 'package:findmyrestaurant/src/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database_models_enum.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  static DatabaseService get instance => _instance;

  DatabaseService._internal();

  final DatabaseModelsEnum _databaseModel = DatabaseModelsEnum.user;

  Future<void> initialize() async {
    Hive.registerAdapter(UserModelAdapter());
    await Hive.initFlutter();
  }

  void saveUserID(String userId) {
    String key = _databaseModel.keysEnum.id.key;
    Box userBox = _databaseModel.box;
    if (userBox.get(key) == null) {
      userBox.put(key, userId);
    }
  }

  String? readUserID() {
    String key = _databaseModel.keysEnum.id.key;
    return _databaseModel.box.get(key);
  }

  void save<T>(DatabaseModelsEnum model, dynamic key, T value) {
    final box = model.box;
    box.put(key, value);
  }

  void delete(DatabaseModelsEnum model, dynamic key) {
    final box = model.box;
    box.delete(key);
  }

  Future<T?> read<T>(DatabaseModelsEnum model, dynamic key) async {
    final box = model.box;
    return box.get(key);
  }
}