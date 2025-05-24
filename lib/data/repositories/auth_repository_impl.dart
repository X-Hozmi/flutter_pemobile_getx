import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/data/datasources/auth_local_data_sources.dart';
import 'package:flutter_pemobile_getx/domain/repositories/auth_repository.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> login(
    String emailOrPhone,
    String password,
  ) async {
    try {
      return Right(await localDataSource.login(emailOrPhone, password));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      return Right(await localDataSource.logout());
    } catch (e) {
      rethrow;
    }
  }
}
