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
  Widget appBarTitleWidget() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartLoadedState) {
        if (state.cartItems.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: appBarTitleWidget(),
            ),
            body: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Empty',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        }
        double? total = state.cartItems
            .map((e) => double.parse(e!.price) * e.quantity)
            .reduce((a, b) => a + b);
        return Scaffold(
            bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.only(bottom: 82.0, left: 10, right: 10),
                child: CheckoutButton(
                  total: total,
                )),
            extendBody: true,
            appBar: AppBar(
              title: appBarTitleWidget(),
            ),
            body: CartItemsList(
              state: state,
            ));
      } else if (state is CartLoadingState) {
        return const Scaffold(
          body: Center(child: spinkit),
        );
      } else if (state is CartErrorState) {
        return Scaffold(
          body: Center(
              child: Text(
            state.error,
            style: const TextStyle(color: Colors.white),
          )),
        );
      }
      return const Scaffold(
        body: Center(
          child: Text(
            'Unknown Error',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
