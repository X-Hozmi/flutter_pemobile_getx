import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/profile_entity.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

abstract class CVRepository {
  Future<Either<Failure, ProfileEntity>> profile();
  Future<Either<Failure, List<Map<String, dynamic>>>> socials();
  Future<Either<Failure, List<Map<String, dynamic>>>> workExperiences();
}
