import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:kachi_bari_pos/core/local/local_data_source.dart';
import 'package:kachi_bari_pos/core/local/model/user_model_isar.dart';
import 'package:kachi_bari_pos/features/auth/data/model/user_model.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalDataSource extends LocalDataSource {
  late Isar isar;



  @override
  Future<bool> initDb() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [UserModelIsarSchema],
        directory: dir.path,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Unit> saveUserModel(User user) async {
    try {
        await isar.writeTxn(
              () async {
            await isar.userModelIsars.put(
                UserModelIsar(
                  userId: user.id,
                  name: user.name,
                  email: user.email,
                  image: user.image,
                  branchId: user.branchId,
                  branchName: user.branchName,
                  role: user.role,
                  isBlocked: user.isBlocked,
                  mobile: user.mobile,
                  token: user.token ?? "",
                ));
          },
        );
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getUserModel() async {
    try {
      final userModelIsar = await isar.userModelIsars.where().findFirst();
      if (userModelIsar != null) {
        return User(
          id: userModelIsar.userId,
          name: userModelIsar.name,
          email: userModelIsar.email,
          image: userModelIsar.image,
          mobile: userModelIsar.mobile,
          role: userModelIsar.role,
          isBlocked: userModelIsar.isBlocked,
          branchId: userModelIsar.branchId,
          branchName: userModelIsar.branchName,
          token: userModelIsar.token,
        );
      } else {
        throw Exception("No user found");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteUserModel() async {
    try {
      await isar.writeTxn(() async {
        await isar.userModelIsars.clear();
      });
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }


}
