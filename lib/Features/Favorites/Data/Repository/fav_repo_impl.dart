import 'package:bloc_online_shop/Features/Favorites/Data/Models/fav_model.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Repository/fav_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavRepoImpl implements FavRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addToFavs({required FavEntity favEntity}) async {
    try {
      await firestore
          .collection('users')
          .doc(favEntity.userId)
          .collection('favorites')
          .doc(favEntity.productId.toString())
          .set(favEntity.toJson, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  @override
  Stream<List<FavEntity?>> getFavItems(String userId) {
    if (userId.isEmpty) {
      throw Exception('UserId cannot be empty');
    }

    try {
      return firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
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
                return FavModel.fromJson(data).toEntity();
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
  Future<void> removeFromFavs(String userId, String productId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId)
        .delete();
  }
}
