part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartStreamEvent extends CartEvent {
  final String userId;

  const FetchCartStreamEvent(this.userId);
}

class UpdateItemQuantityEvent extends CartEvent {
  final OrderEntity orderEntity;

  const UpdateItemQuantityEvent({required this.orderEntity});
}

class RemoveItemFromCartEvent extends CartEvent {
  final int productId;

  const RemoveItemFromCartEvent({required this.productId});
}
