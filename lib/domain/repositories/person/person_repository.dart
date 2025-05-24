import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/person/person.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<Person>>> get();
  Future<Either<Failure, String>> save(Person person);
  Future<Either<Failure, String>> remove(Person person);
  Future<bool> isAddedTo(int id);
}
