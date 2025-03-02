part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends OrderEvent {
  final OrderEntity orderEntity;
  const AddToCartEvent(this.orderEntity);
}

class AddToFavsEvent extends OrderEvent {
  final FavEntity favEntity;
  const AddToFavsEvent(this.favEntity);
}
