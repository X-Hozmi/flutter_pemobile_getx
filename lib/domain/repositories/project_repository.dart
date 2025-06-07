import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/project/project.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<Project>>> getProjects();
}
