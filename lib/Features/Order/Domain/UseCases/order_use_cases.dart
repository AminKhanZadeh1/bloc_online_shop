import 'package:bloc_online_shop/Core/Utils/Params/params.dart';
import 'package:bloc_online_shop/Features/Cart/Domain/Repository/cart_repo.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Repository/fav_repo.dart';
import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';

class AddToCartUseCase implements UseCase<void, OrderEntity> {
  final CartRepo _cartRepo;

  AddToCartUseCase(this._cartRepo);
  @override
  Future<void> call(OrderEntity params) {
    return _cartRepo.addToCart(orderEntity: params);
  }
}

class AddToFavsUseCase implements UseCase<void, FavEntity> {
  final FavRepo _favRepo;

  const AddToFavsUseCase(this._favRepo);

  @override
  Future<void> call(FavEntity params) {
    return _favRepo.addToFavs(favEntity: params);
  }
}
