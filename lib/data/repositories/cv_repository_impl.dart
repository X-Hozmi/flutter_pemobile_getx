import 'dart:async';

import 'package:flutter_pemobile_getx/data/datasources/cv_local_data_sources.dart';
import 'package:flutter_pemobile_getx/domain/entities/profile_entity.dart';
import 'package:flutter_pemobile_getx/domain/repositories/cv_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/utils/exception.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class CVRepositoryImpl implements CVRepository {
  final CVLocalDataSource localDataSource;

  CVRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> profile() async {
    try {
      final result = await localDataSource.profile();
      return Right(result.toEntity());
    } on CacheException {
      return const Left(CacheFailure('Gagal mengambil data'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> socials() async {
    try {
      final result = await localDataSource.socials();
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure('Gagal mengambil data'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> workExperiences() async {
    try {
      final result = await localDataSource.workExperiences();
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure('Gagal mengambil data'));
    }
  }
}
