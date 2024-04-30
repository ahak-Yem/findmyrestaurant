import 'database_models_enum.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<void> save<T>(DatabaseModelsEnum model, dynamic key, T value) async {
    final box = await model.box;
    await box.put(key, value);
  }

  Future<void> delete(DatabaseModelsEnum model, dynamic key) async {
    final box = await model.box;
    await box.delete(key);
  }

  Future<T?> read<T>(DatabaseModelsEnum model, dynamic key) async {
    final box = await model.box;
    return box.get(key);
  }
}