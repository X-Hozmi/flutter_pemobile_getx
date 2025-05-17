import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/profile_entity.dart';
import 'package:flutter_pemobile_getx/domain/repositories/cv_repository.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class GetProfile {
  final CVRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, ProfileEntity>> execute() {
    return repository.profile();
  }
}
