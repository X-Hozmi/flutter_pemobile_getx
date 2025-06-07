import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/project/project.dart';
import 'package:flutter_pemobile_getx/domain/repositories/project_repository.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class GetProjects {
  final ProjectRepository repository;

  GetProjects(this.repository);

  Future<Either<Failure, List<Project>>> execute() {
    return repository.getProjects();
  }
}
