import 'package:dartz/dartz.dart';

import '../../features/auth/data/model/user_model.dart';

abstract class LocalDataSource{
  Future<bool> initDb();
  Future<Unit> saveUserModel(User user);
  Future<User> getUserModel();
  Future<Unit> deleteUserModel();


}