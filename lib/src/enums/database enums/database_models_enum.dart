import 'package:hive_flutter/hive_flutter.dart';
import 'user_model_keys_enum.dart';

enum DatabaseModelsEnum {
  user,
}

extension DatabaseModelsEnumExtension on DatabaseModelsEnum {
  String get boxName {
    switch (this) {
      case DatabaseModelsEnum.user:
        return 'userBox';
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

  Future<Box<dynamic>> get box async{
    return await Hive.openBox(boxName);
  }

  List<String> get keysEnum {
    switch (this){
      case DatabaseModelsEnum.user:
        return [
          UserModelKeysEnum.id.key, 
          UserModelKeysEnum.name.key,
          UserModelKeysEnum.email.key,
          UserModelKeysEnum.profilePicture.key
        ].toList();
      default:
       throw Exception('Invalid Enum Value!');
    }
  }
}