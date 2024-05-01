import '../../user/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database_models_enum.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  static DatabaseService get instance => _instance;

  DatabaseService._internal();

  final DatabaseModelsEnum _userDatabaseModelEnum = DatabaseModelsEnum.user;

  Future<void> initialize() async {
    Hive.registerAdapter(UserModelAdapter());
    await Hive.initFlutter();
  }

  void saveUserID(String userId) {
    Box userBox = _userDatabaseModelEnum.box as Box;
    String key = _userDatabaseModelEnum.keysEnum.id.key;
    if (userBox.get(key) == null) {
      userBox.put(key, userId);
    }
  }

  String? readUserID() {
    Box userBox = _userDatabaseModelEnum.box as Box;
    String key = _userDatabaseModelEnum.keysEnum.id.key;
    return userBox.get(key);
  }

  void save<T>(DatabaseModelsEnum model, dynamic key, T value) {
    final box = model.box as Box;
    box.put(key, value);
  }

  void delete(DatabaseModelsEnum model, dynamic key) {
    final box = model.box as Box;
    box.delete(key);
  }

  Future<T?> read<T>(DatabaseModelsEnum model, dynamic key) async {
    final box = model.box as Box;
    return box.get(key);
  }
}