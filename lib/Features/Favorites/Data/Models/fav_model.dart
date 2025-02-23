import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';

class FavModel extends FavEntity {
  const FavModel({
    required super.userId,
    required super.productId,
    required super.productName,
    required super.image,
    required super.price,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
        userId: json['userId'],
        productId: json['productId'],
        productName: json['productName'],
        image: json['image'],
        price: json['price'],
      );
}
