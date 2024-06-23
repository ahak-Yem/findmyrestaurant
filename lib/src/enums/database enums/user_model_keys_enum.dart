enum UserModelKeysEnum{
  id,
  name,
  email,
  profilePicture;
}

extension UserModelKeysEnumExtension on UserModelKeysEnum {
  String get key {
    switch (this) {
      case UserModelKeysEnum.id:
        return "id";
      case UserModelKeysEnum.name:
        return "name";
      case UserModelKeysEnum.email:
        return "email";
      case UserModelKeysEnum.profilePicture:
        return "profilePicture";
    }
  }
}