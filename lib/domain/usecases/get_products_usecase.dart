import 'package:dartz/dartz.dart';
import 'package:flutter_pemobile_getx/domain/entities/product/product.dart';
import 'package:flutter_pemobile_getx/domain/repositories/product_repository.dart';
import 'package:flutter_pemobile_getx/utils/failure.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> execute() {
    return repository.getProducts();
  }
}
