import 'package:flutter_pemobile_getx/data/datasources/db/database_helper.dart';
import 'package:flutter_pemobile_getx/data/models/person/person_table.dart';
import 'package:flutter_pemobile_getx/utils/exception.dart';

abstract class PersonLocalDataSource {
  Future<String> insert(PersonTable person);
  Future<String> remove(PersonTable person);
  Future<PersonTable?> getPersonById(int id);
  Future<List<PersonTable>> getPersons();
}

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final DatabaseHelper databaseHelper;

  PersonLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<PersonTable>> getPersons() async {
    final result = await databaseHelper.getPersons();
    return result.map((data) => PersonTable.fromMap(data)).toList();
  }

  @override
  Future<String> insert(PersonTable person) async {
    try {
      await databaseHelper.insertPerson(person);
      return 'Ditambahkan ke daftar orang';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> remove(PersonTable person) async {
    try {
      await databaseHelper.removePerson(person);
      return 'Dihapus dari daftar orang';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<PersonTable?> getPersonById(int id) async {
    final result = await databaseHelper.getPersonById(id);
    if (result != null) {
      return PersonTable.fromMap(result);
    } else {
      return null;
    }
  }
}
