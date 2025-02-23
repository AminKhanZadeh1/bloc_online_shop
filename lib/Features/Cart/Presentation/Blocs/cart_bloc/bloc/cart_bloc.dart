import 'package:bloc_online_shop/Core/Utils/UserAuth_Check/user_auth.dart';
import 'package:bloc_online_shop/Features/Cart/Domain/UseCases/cart_use_cases.dart';
import 'package:bloc_online_shop/Features/Cart/Domain/Repository/cart_repo.dart';
import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo _cartRepository;
  List<OrderEntity> cartList = [];

  CartBloc(this._cartRepository) : super(CartLoadingState()) {
    on<FetchCartStreamEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        final cartItemsStream =
            FetchCartItemsUseCase(_cartRepository).call(UserAuth.userId);

        await emit.onEach(
          cartItemsStream,
          onData: (data) {
            final updatedCartList = data.whereType<OrderEntity>().toList();
            cartList = updatedCartList;
            emit(CartLoadedState(updatedCartList));
          },
        );
      } catch (error) {
        emit(CartErrorState(error.toString()));
      }
    });
    on<UpdateItemQuantityEvent>(
      (event, emit) {
        UpdateItemQuantityUseCase(_cartRepository).call(event.orderEntity);
        int index = cartList.indexWhere(
            (element) => element.productId == event.orderEntity.productId);
        final updatedCartList = List<OrderEntity>.from(cartList);
        updatedCartList[index] = event.orderEntity;
        emit(CartLoadedState(updatedCartList));
      },
    );
    on<RemoveItemFromCartEvent>(
      (event, emit) {
        RemoveItemFromCartUseCase(_cartRepository).call(event.productId);
        final updatedCartList = List<OrderEntity>.from(cartList);
        updatedCartList
            .removeWhere((item) => item.productId == event.productId);
        emit(CartLoadedState(updatedCartList));
      },
    );
  }
}
