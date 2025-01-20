
import 'package:dartz/dartz.dart';
import '../../../../core/network/failure.dart';
import '../../data/model/login_request_dto.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signInWithEmailPassword(LoginRequestDto loginRequestDto);
  Future<Either<Failure, User>> getUserData();
  Future<bool> signOut();

}