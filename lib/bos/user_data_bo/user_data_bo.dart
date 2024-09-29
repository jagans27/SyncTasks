import 'package:hive_flutter/adapters.dart';

part 'user_data_bo.g.dart';

@HiveType(typeId: 3)
class UserDataBO {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String? profileUrl;

  UserDataBO(
      {required this.name, required this.email, required this.profileUrl});
}
