import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String? profilePicture;

  UserModel(this.id, {required this.name, required this.email, this.profilePicture});
}
