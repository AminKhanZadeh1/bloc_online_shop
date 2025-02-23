import 'package:equatable/equatable.dart';

class FavEntity extends Equatable {
  final String userId;
  final int productId;
  final String productName;
  final String image;
  final String price;
  const FavEntity(
      {required this.userId,
      required this.productId,
      required this.productName,
      required this.image,
      required this.price});

  @override
  List<Object?> get props => [userId, productId, productName, image, price];

  Map<String, dynamic> get toJson => {
        'userId': userId,
        'productId': productId,
        'productName': productName,
        'image': image,
        'price': price,
      };

  FavEntity toEntity() {
    return FavEntity(
      userId: userId,
      productId: productId,
      productName: productName,
      image: image,
      price: price,
    );
  }
}
