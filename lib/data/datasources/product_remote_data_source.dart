import 'dart:async';
import 'dart:convert';

import 'package:flutter_pemobile_getx/data/models/product/product_model.dart';
import 'package:flutter_pemobile_getx/utils/constant.dart';
import 'package:flutter_pemobile_getx/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final Duration timeoutDuration;

  ProductRemoteDataSourceImpl({
    required this.client,
    this.timeoutDuration = const Duration(seconds: 10),
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client
          .get(
            Uri.parse('$dummyJsonUrl/products?skip=0&limit=10'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return ProductModel.fromApiResponse(jsonResponse);
      } else {
        throw ServerException();
      }
    } on TimeoutException {
      throw TimeoutException('Request to get products timed out');
    } on FormatException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
