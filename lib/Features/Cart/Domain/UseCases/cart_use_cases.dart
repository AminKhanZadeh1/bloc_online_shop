import 'package:bloc_online_shop/Core/Utils/Params/params.dart';
import 'package:bloc_online_shop/Core/Utils/UserAuth_Check/user_auth.dart';
import 'package:bloc_online_shop/Features/Cart/Domain/Repository/cart_repo.dart';
import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';

class FetchCartItemsUseCase
    implements StreamUseCase<List<OrderEntity?>, String> {
  final CartRepo _cartRepo;

  const FetchCartItemsUseCase(this._cartRepo);

  @override
  Stream<List<OrderEntity?>> call(String params) {
    return _cartRepo.getCartItems(params);
  }
}

class RemoveItemFromCartUseCase implements UseCase<void, int> {
  final CartRepo _cartRepo;

  const RemoveItemFromCartUseCase(this._cartRepo);

  @override
  Future<void> call(int params) async {
    return _cartRepo.removeFromCart(UserAuth.userId, params.toString());
  }
}

class UpdateItemQuantityUseCase implements UseCase<void, OrderEntity> {
  final CartRepo _cartRepo;

  const UpdateItemQuantityUseCase(this._cartRepo);
  @override
  Future<void> call(OrderEntity params) {
    return _cartRepo.updateItemQuantity(orderEntity: params);
  }
}
