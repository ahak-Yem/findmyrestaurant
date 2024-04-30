import 'package:hive/hive.dart';

enum DatabaseModelsEnum {
  user("userBox");

  const  DatabaseModelsEnum(String boxName);
}

extension DatabaseModelsEnumExtension on DatabaseModelsEnum {
  String get boxName {
    switch (this) {
      case DatabaseModelsEnum.user:
        return DatabaseModelsEnum.user.boxName;
      default:
        throw Exception('Invalid enum value');
    }
  }

  bool get isSingleton {
    switch (this) {
      case DatabaseModelsEnum.user:
        return true;
      default:
        throw Exception('Invalid enum value');
    }
  }

  Box<dynamic> get box {
    return Hive.box(boxName);
  }
}