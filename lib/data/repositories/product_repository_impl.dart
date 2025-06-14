import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/data/datasources/product_remote_data_source.dart';
import 'package:flutter_pemobile_getx/domain/entities/product/product.dart';
import 'package:flutter_pemobile_getx/domain/repositories/product_repository.dart';
import 'package:flutter_pemobile_getx/utils/exception.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModels = await remoteDataSource.getProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } on ServerException {
      return Left(
        ServerFailure('Something\'s wrong from server. Please try again later'),
      );
    } on TimeoutException {
      return Left(
        TimeoutFailure(
          'Connection timed out. Maybe check your internet connection?',
        ),
      );
    } catch (e) {
      return Left(UnexpectedFailure('An unexpected error occurred: $e'));
    }
  }
}
