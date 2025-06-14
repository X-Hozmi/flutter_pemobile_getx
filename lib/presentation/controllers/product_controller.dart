import 'package:flutter_pemobile_getx/domain/entities/product/product.dart';
import 'package:flutter_pemobile_getx/domain/usecases/get_products_usecase.dart';
import 'package:flutter_pemobile_getx/utils/state_enum.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final GetProducts getProductsUseCase;

  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final RxList<Product> _products = RxList<Product>([]);

  RequestState get state => _state.value;
  String get message => _message.value;
  List<Product> get products => _products;

  ProductController({required this.getProductsUseCase});

  Future<void> getProducts() async {
    _state.value = RequestState.loading;
    update();

    final result = await getProductsUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
        _products.clear();
      },
      (success) {
        if (success.isEmpty) {
          _state.value = RequestState.empty;
          _message.value = 'No products available yet.';
          _products.clear();
        } else {
          _state.value = RequestState.loaded;
          _message.value = '';
          _products.value = success;
        }
      },
    );

    update();
  }

  Future<void> refreshProducts() async {
    await getProducts();
  }

  void clearProducts() {
    _products.clear();
    _state.value = RequestState.initial;
    _message.value = '';
    update();
  }
}
