import 'package:bloc_online_shop/Config/Theme/Colors/g_color.dart';
import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Core/Utils/UserAuth_Check/user_auth.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';
import 'package:bloc_online_shop/Features/Favorites/Presentation/Blocs/bloc/favorites_bloc.dart';
import 'package:bloc_online_shop/Features/Shared/Models/rating_model.dart';
import 'package:bloc_online_shop/Features/Order/Presentation/Blocs/order_bloc/bloc/order_bloc.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/blocs/product_bloc/bloc/product_bloc.dart';
import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class OrderScreen extends StatelessWidget {
  final int productId;

  const OrderScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final productState = BlocProvider.of<ProductBloc>(context).state;
    final item = productState is FetchProductsSuccessState
        ? productState.products.firstWhere(
            (element) => element.id == productId,
          )
        : const ProductEntity(
            id: 0,
            title: 'title',
            price: 0,
            description: 'description',
            category: 'category',
            image: 'image',
            rating: Rating(rate: 0, count: 0));
    final state = BlocProvider.of<FavoritesBloc>(context).state;
    final favItem = state is FavsLoadedState
        ? state.favProducts.firstWhere(
            (element) => element!.productId == productId,
          )
        : null;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(IconlyBold.arrow_left),
        ),
      ),
      body: _buildBody(context, item, favItem),
      bottomNavigationBar: _buildBottomNavigationBar(
          context,
          OrderEntity(
              userId: UserAuth.userId,
              productId: item.id,
              productName: item.title,
              image: item.image,
              price: item.finalPrice.toStringAsFixed(2),
              quantity: 0)),
    );
  }

  Widget _buildBody(BuildContext context, ProductEntity item, favItem) {
    return _buildProductDetails(context, item, favItem);
  }

  Widget _buildProductDetails(
      BuildContext context, ProductEntity item, favItem) {
    return ListView(
      key: const PageStorageKey('orderScreenList'),
      padding: const EdgeInsets.all(16.0),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 300,
            width: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: item.image,
                placeholder: (context, url) => SpinKitFadingCircle(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          textAlign: TextAlign.center,
          item.title,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 30),
        Text(
          item.description,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        IconButton(
          onPressed: () {
            if (favItem == null) {
              BlocProvider.of<OrderBloc>(context).add(AddToFavsEvent(FavEntity(
                  userId: UserAuth.userId,
                  productId: item.id,
                  productName: item.title,
                  image: item.image,
                  price: item.price.toString())));
            } else {
              BlocProvider.of<FavoritesBloc>(context)
                  .add(RemoveFromFavsEvent(productId: productId));
            }
          },
          icon: favItem == null
              ? const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                ),
        ),
        RatingBarIndicator(
          rating: item.rating.rate,
          itemBuilder: (context, index) =>
              const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 24.0,
          direction: Axis.horizontal,
        )
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, OrderEntity item) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          final cartItem = state.cartItems.firstWhere(
              (element) => element!.productId == productId,
              orElse: () => item);

          if (cartItem != null && cartItem.quantity > 0) {
            return _buildCartControls(context, cartItem);
          }
          return _buildAddToCartButton(context, cartItem!);
        }
        if (state is CartLoadingState) {
          return Center(
              child: Theme.of(context).brightness == Brightness.light
                  ? blackSpinkit
                  : whiteSpinkit);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCartControls(BuildContext context, OrderEntity cartItem) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 65,
        decoration: BoxDecoration(
          border: Theme.of(context).brightness == Brightness.dark
              ? Border.all(width: 2, color: Colors.white)
              : null,
          color: Theme.of(context).brightness == Brightness.light
              ? const Color.fromARGB(255, 218, 238, 255)
              : Colors.deepPurple,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => _updateCartQuantity(context, cartItem, -1),
              icon: Icon(cartItem.quantity == 1 ? Icons.delete : Icons.remove),
            ),
            Text(
              cartItem.quantity.toString(),
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () => _updateCartQuantity(context, cartItem, 1),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, OrderEntity item) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 65,
        child: ElevatedButton(
          style: ButtonStyle(
              side: WidgetStatePropertyAll(
                Theme.of(context).brightness == Brightness.dark
                    ? const BorderSide(width: 2, color: Colors.white)
                    : null,
              ),
              backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(255, 218, 238, 255)
                      : Colors.deepPurple),
              foregroundColor: WidgetStatePropertyAll(
                  Theme.of(context).brightness == Brightness.light
                      ? GColor.black
                      : GColor.white)),
          onPressed: () {
            final order = OrderEntity(
              userId: UserAuth.userId,
              productId: item.productId,
              productName: item.productName,
              image: item.image,
              price: item.price,
              quantity: 1,
            );
            context.read<OrderBloc>().add(AddToCartEvent(order));
          },
          child: Text(
            'Add To Cart',
            style: GoogleFonts.aladin(fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _updateCartQuantity(
      BuildContext context, OrderEntity cartItem, int delta) {
    final newQuantity = cartItem.quantity + delta;
    if (newQuantity <= 0) {
      context.read<CartBloc>().add(RemoveItemFromCartEvent(
            productId: cartItem.productId,
          ));
    } else {
      final updatedItem = cartItem.copyWith(quantity: newQuantity);
      context.read<CartBloc>().add(UpdateItemQuantityEvent(
            orderEntity: updatedItem,
          ));
    }
  }
}
