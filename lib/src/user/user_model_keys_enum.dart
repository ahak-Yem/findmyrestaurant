enum UserModelKeysEnum{
  id("id"),
  name("name"),
  email("email"),
  profilePicture("picture");

  const UserModelKeysEnum(String key);
}

extension UserModelKeysEnumExtension on UserModelKeysEnum {
  String get key {
    switch (this) {
      case UserModelKeysEnum.id:
        return UserModelKeysEnum.id.key;
      case UserModelKeysEnum.name:
        return UserModelKeysEnum.name.key;
      case UserModelKeysEnum.email:
        return UserModelKeysEnum.email.key;
      case UserModelKeysEnum.profilePicture:
        return UserModelKeysEnum.profilePicture.key;
    }
  }
}