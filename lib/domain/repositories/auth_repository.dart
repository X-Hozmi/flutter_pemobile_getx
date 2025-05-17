import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(String emailOrPhone, String password);
  Future<Either<Failure, bool>> logout();
}
