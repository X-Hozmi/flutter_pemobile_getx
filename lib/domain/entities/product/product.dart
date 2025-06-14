import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String category;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<dynamic> images;

  const Product({
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
