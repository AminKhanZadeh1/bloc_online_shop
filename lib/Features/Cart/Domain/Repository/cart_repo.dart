import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';

abstract class CartRepo {
  Stream<List<OrderEntity?>> getCartItems(String userId);
  Future<void> removeFromCart(String userId, String productId);
  Future<void> addToCart({required OrderEntity orderEntity});
  Future<void> updateItemQuantity({required OrderEntity orderEntity});
}
