import 'package:equatable/equatable.dart';
import 'package:flutter_pemobile_getx/domain/entities/product/product.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;

  const ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((image) => image.toString())
              .toList() ??
          [],
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static List<ProductModel> fromApiResponse(Map<String, dynamic> apiResponse) {
    final productsJson = apiResponse['products'] as List<dynamic>? ?? [];
    return fromJsonList(productsJson);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'thumbnail': thumbnail,
      'images': images,
    };
  }

  Product toEntity() {
    return Product(
      id: id,
      title: title,
      category: category,
      price: price.toInt(),
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      brand: brand,
      thumbnail: thumbnail,
      images: images,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    brand,
    thumbnail,
    images,
  ];
}
