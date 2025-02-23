import 'package:bloc_online_shop/Features/Shared/Models/rating_model.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: (json["price"] as num).toDouble(),
        description: json["description"],
        category: json["category"] ?? "All",
        image: json["image"],
        rating: Rating.fromJson(
          json["rating"],
        ),
      );
}
