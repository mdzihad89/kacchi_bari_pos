import 'package:isar/isar.dart';

part 'user_model_isar.g.dart';


@collection
class UserModelIsar {
  Id id = Isar.autoIncrement;
   @Index(unique: true)
   String userId;
   String name;
   String email;
   String image;
   String mobile;
   String role;
   bool isBlocked;
   String token;
   String branchId;
   String branchName;

  UserModelIsar({
    required this.userId,
    required this.name,
    required this.email,
    required this.image,
    required this.mobile,
    required this.role,
    required this.isBlocked,
    required this.branchId,
    required this.branchName,
    required this.token,
  });
}