import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';
import 'package:bloc_online_shop/Features/Favorites/Presentation/Blocs/bloc/favorites_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavItemsList extends StatelessWidget {
  final FavsLoadedState state;
  const FavItemsList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
      child: ListView.builder(
        itemExtent: 90,
        shrinkWrap: true,
        itemCount: state.favProducts.length,
        itemBuilder: (context, index) {
          FavEntity item = state.favProducts[index]!;
          return GestureDetector(
            onTap: () {
              context.push('/order', extra: item.productId);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CachedNetworkImage(imageUrl: item.image),
                    Text(item.productName),
                    Text(item.price),
                    IconButton(
                        onPressed: () => context.read<FavoritesBloc>().add(
                            RemoveFromFavsEvent(productId: item.productId)),
                        icon: const Icon(Icons.delete))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
