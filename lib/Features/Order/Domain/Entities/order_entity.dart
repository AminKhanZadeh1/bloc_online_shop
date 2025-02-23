import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class OrderEntity extends Equatable {
  final String userId;
  final int productId;
  final String productName;
  final String image;
  final String price;
  final int quantity;
  const OrderEntity(
      {required this.userId,
      required this.productId,
      required this.productName,
      required this.image,
      required this.price,
      required this.quantity});
  @override
  List<Object?> get props =>
      [userId, productId, productName, image, price, quantity];

  Map<String, dynamic> get toJson => {
        'userId': userId,
        'productId': productId,
        'productName': productName,
        'image': image,
        'price': price,
        'quantity': quantity,
      };

  OrderEntity toEntity() {
    return OrderEntity(
        userId: userId,
        productId: productId,
        productName: productName,
        image: image,
        price: price,
        quantity: quantity);
  }

  OrderEntity copyWith(
      {String? userId,
      int? productId,
      String? productName,
      String? image,
      String? price,
      int? quantity}) {
    return OrderEntity(
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        image: image ?? this.image,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity);
  }
}
