import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/data/datasources/person_local_data_source.dart';
import 'package:flutter_pemobile_getx/data/models/person/person_table.dart';
import 'package:flutter_pemobile_getx/domain/entities/person/person.dart';
import 'package:flutter_pemobile_getx/domain/repositories/person/person_repository.dart';
import 'package:flutter_pemobile_getx/utils/exception.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonLocalDataSource localDataSource;

  PersonRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Person>>> get() async {
    final result = await localDataSource.getPersons();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, String>> save(Person person) async {
    try {
      final result = await localDataSource.insert(
        PersonTable.fromEntity(person),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> remove(Person person) async {
    try {
      final result = await localDataSource.remove(
        PersonTable.fromEntity(person),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedTo(int id) async {
    final result = await localDataSource.getPersonById(id);
    return result != null;
  }
}
