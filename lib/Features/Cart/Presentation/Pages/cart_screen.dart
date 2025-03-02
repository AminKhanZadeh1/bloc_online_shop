import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Widgets/cart_items_list.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Widgets/checkout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartLoadedState) {
        if (state.cartItems.isEmpty) {
          return const Scaffold(
            extendBody: true,
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Empty',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          );
        }
        double? total = state.cartItems
            .map((e) => double.parse(e!.price) * e.quantity)
            .reduce((a, b) => a + b);
        return Scaffold(
            extendBody: true,
            bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.only(bottom: 82.0, left: 10, right: 10),
                child: CheckoutButton(
                  total: total,
                )),
            body: CartItemsList(
              state: state,
            ));
      } else if (state is CartLoadingState) {
        return Scaffold(
          body: Center(child: spinkit),
        );
      } else if (state is CartErrorState) {
        return Scaffold(
          body: Center(
              child: Text(
            state.error,
          )),
        );
      }
      return const Scaffold(
        body: Center(
          child: Text(
            'Unknown Error',
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
