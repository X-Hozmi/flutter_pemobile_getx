import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/person/person.dart';
import 'package:flutter_pemobile_getx/domain/repositories/person/person_repository.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class GetPerson {
  final PersonRepository repository;

  GetPerson(this.repository);

  Future<Either<Failure, List<Person>>> execute() {
    return repository.get();
  }
}
