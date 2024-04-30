import 'package:hive/hive.dart';

enum DatabaseModelsEnum {
  userProfile(true);

  const DatabaseModelsEnum(bool isSingleton);
}

extension AppBoxExtension on DatabaseModelsEnum {
  String get boxName {
    switch (this) {
      case DatabaseModelsEnum.userProfile:
        return 'userBox';
      default:
        throw Exception('Invalid enum value');
    }
  }

  Future<Box<dynamic>> get box async {
    switch (this) {
      case DatabaseModelsEnum.userProfile:
        return Hive.openBox(boxName);
      default:
        throw Exception('Invalid enum value');
    }
  }
}