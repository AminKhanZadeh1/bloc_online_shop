part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<OrderEntity?> cartItems;

  const CartLoadedState(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class CartErrorState extends CartState {
  final String error;

  const CartErrorState(this.error);
}
