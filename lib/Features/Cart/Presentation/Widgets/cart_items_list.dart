import 'package:bloc_online_shop/Config/Theme/Theme_Cubit/cubit/theme_cubit.dart';
import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartItemsList extends StatelessWidget {
  final CartLoadedState state;
  const CartItemsList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 70, top: 90),
      itemExtent: 180,
      shrinkWrap: true,
      itemCount: state.cartItems.length,
      itemBuilder: (context, index) {
        OrderEntity item = state.cartItems[index]!;
        return GestureDetector(
          onTap: () {
            context.push('/order', extra: item.productId);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                BlocBuilder<ThemeCubit, ThemeData>(
                  builder: (context, state) {
                    return Container(
                        height: 85,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: state.brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                            color: state.brightness == Brightness.light
                                ? Colors.white70
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 35,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.25,
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          item.productName,
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "\$${item.price}",
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              _buildQuantityButtons(context, item),
                            ]));
                  },
                ),
                Positioned(
                  top: -70,
                  left: 8,
                  child: SizedBox(
                    height: 120,
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: item.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(child: spinkit),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantityButtons(BuildContext context, OrderEntity item) {
    return Center(
      child: Container(
          margin: const EdgeInsets.only(right: 5),
          height: 45,
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(255, 220, 244, 255)
                  : const Color.fromARGB(255, 18, 18, 18)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
                onPressed: () {
                  OrderEntity updatedItem =
                      item.copyWith(quantity: item.quantity - 1);
                  item.quantity == 1
                      ? context.read<CartBloc>().add(
                          RemoveItemFromCartEvent(productId: item.productId))
                      : context.read<CartBloc>().add(
                          UpdateItemQuantityEvent(orderEntity: updatedItem));
                },
                icon: Icon(
                  item.quantity == 1 ? Icons.delete : Icons.remove,
                  size: Checkbox.width,
                )),
            Text(
              item.quantity.toString(),
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
                onPressed: () {
                  OrderEntity updatedItem =
                      item.copyWith(quantity: item.quantity + 1);
                  if (item.quantity == 9) {
                    return;
                  }
                  context
                      .read<CartBloc>()
                      .add(UpdateItemQuantityEvent(orderEntity: updatedItem));
                },
                icon: const Icon(
                  Icons.add,
                  size: Checkbox.width,
                )),
          ])),
    );
  }
}
