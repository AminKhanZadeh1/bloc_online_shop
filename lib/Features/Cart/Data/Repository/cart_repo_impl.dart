import 'package:bloc_online_shop/Core/Utils/UserAuth_Check/user_auth.dart';
import 'package:bloc_online_shop/Features/Cart/Domain/Repository/cart_repo.dart';
import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';
import 'package:bloc_online_shop/Features/Order/Data/Models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartRepoImpl implements CartRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Stream<List<OrderEntity?>> getCartItems(String userId) {
    if (userId.isEmpty) {
      throw Exception('UserId cannot be empty');
    }

    try {
      return firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isEmpty) {
          return [];
        }

        return snapshot.docs
            .map((doc) {
              try {
                final data = doc.data();

                String? productName = data['productName'];
                if (productName == null) {
                  productName = 'Unknown Product';
                  throw Exception(
                      'Warning: productName is missing for docId: ${doc.id}');
                }

                String? price = data['price'];
                if (price == null) {
                  price = '0';
                  throw Exception(
                      'Warning: price is missing for docId: ${doc.id}');
                }

                return OrderModel.fromJson(data).toEntity();
              } catch (e) {
                throw Exception(
                    'Error converting document to OrderModel: ${e.toString()}');
              }
            })
            // ignore: unnecessary_null_comparison
            .where((item) => item != null)
            .toList();
      });
    } catch (e, stackTrace) {
      throw Exception(
          'Error fetching cart items in cart Repo: ${e.toString()} $stackTrace');
    }
  }

  @override
  Future<void> removeFromCart(String userId, String productId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .delete();
  }

  @override
  Future<void> addToCart({required OrderEntity orderEntity}) async {
    try {
      await firestore
          .collection('users')
          .doc(orderEntity.userId)
          .collection('cart')
          .doc(orderEntity.productId.toString())
          .set(orderEntity.toJson, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  @override
  Future<void> updateItemQuantity({required OrderEntity orderEntity}) async {
    await firestore
        .collection('users')
        .doc(UserAuth.userId)
        .collection('cart')
        .doc(orderEntity.productId.toString())
        .update({'quantity': orderEntity.quantity});
  }
}
