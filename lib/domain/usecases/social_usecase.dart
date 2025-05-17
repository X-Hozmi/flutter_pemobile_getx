import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/repositories/cv_repository.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class GetSocials {
  final CVRepository repository;

  GetSocials(this.repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> execute() {
    return repository.socials();
  }
}
