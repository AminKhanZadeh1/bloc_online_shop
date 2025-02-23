import 'package:bloc_online_shop/Features/Shared/Models/rating_model.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;
  final double? discount;

  const ProductEntity(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating,
      this.discount});

  ProductEntity copyWith(
      {int? id,
      String? title,
      double? price,
      String? description,
      String? category,
      String? image,
      Rating? rating,
      double? discount}) {
    return ProductEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        discount: discount ?? this.discount);
  }

  double get finalPrice =>
      discount != null ? price * (1 - discount! / 100) : price;

  @override
  List<Object?> get props =>
      [id, title, price, description, category, image, rating];

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
    );
  }

  ProductEntity toDoc() {
    return ProductEntity(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: rating,
        discount: discount);
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating
      };
}
