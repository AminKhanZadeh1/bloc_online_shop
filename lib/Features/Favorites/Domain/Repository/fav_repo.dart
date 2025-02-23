import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';

abstract class FavRepo {
  Stream<List<FavEntity?>> getFavItems(String userId);
  Future<void> removeFromFavs(String userId, String productId);
  Future<void> addToFavs({required FavEntity favEntity});
}
