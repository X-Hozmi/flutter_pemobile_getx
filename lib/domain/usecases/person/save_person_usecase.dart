import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/person/person.dart';
import 'package:flutter_pemobile_getx/domain/repositories/person/person_repository.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class SavePerson {
  final PersonRepository repository;

  SavePerson(this.repository);

  Future<Either<Failure, String>> execute(Person person) {
    return repository.save(person);
  }
}
