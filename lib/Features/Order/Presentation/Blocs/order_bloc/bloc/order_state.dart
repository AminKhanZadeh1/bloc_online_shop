part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

class AddedToCartState extends OrderState {}

class ProductInCart extends OrderState {
  final String productId;
  final int quantity;

  const ProductInCart(this.productId, this.quantity);
}

class ProductNotInCart extends OrderState {}

class AddedToFavState extends OrderState {}
