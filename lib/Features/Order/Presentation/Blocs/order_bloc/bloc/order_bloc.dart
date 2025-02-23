import 'package:bloc/bloc.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Repository/fav_repo.dart';
import 'package:bloc_online_shop/Features/Order/Domain/UseCases/order_use_cases.dart';
import 'package:bloc_online_shop/Features/Cart/Domain/Repository/cart_repo.dart';
import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CartRepo _cartRepo;
  final FavRepo _favRepo;
  OrderBloc(this._cartRepo, this._favRepo) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      if (event is AddToCartEvent) {
        try {
          await AddToCartUseCase(_cartRepo).call(event.orderEntity);
          emit(AddedToCartState());
        } catch (e) {
          throw Exception(e.toString());
        }
      }
      if (event is AddToFavsEvent) {
        try {
          await AddToFavsUseCase(_favRepo).call(event.favEntity);
          emit(AddedToFavState());
        } catch (e) {
          throw Exception(e.toString());
        }
      }
    });
  }
}
