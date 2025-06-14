import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/product/product.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
