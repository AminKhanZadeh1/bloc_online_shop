import 'package:bloc_online_shop/Features/Shared/Models/rating_model.dart';
import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String image;
  final Rating rating;
  final double? discount;

  const CategoriesEntity(
      {required this.id,
      required this.title,
      required this.price,
      required this.image,
      required this.rating,
      this.discount});

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        image,
        rating,
      ];

  CategoriesEntity toEntity() => CategoriesEntity(
      id: id, title: title, price: price, image: image, rating: rating);
}
