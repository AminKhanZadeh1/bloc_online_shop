import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel(
      {required super.userId,
      required super.productId,
      required super.productName,
      required super.image,
      required super.price,
      required super.quantity});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      userId: json['userId'],
      productId: json['productId'],
      productName: json['productName'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity']);
}
