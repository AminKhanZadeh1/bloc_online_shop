import 'package:bloc_online_shop/Config/Theme/Theme_Cubit/cubit/theme_cubit.dart';
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
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 30),
      child: ListView.builder(
        itemExtent: 110,
        shrinkWrap: true,
        itemCount: state.favProducts.length,
        itemBuilder: (context, index) {
          FavEntity item = state.favProducts[index]!;
          return GestureDetector(
            onTap: () {
              context.push('/order', extra: item.productId);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: BlocBuilder<ThemeCubit, ThemeData>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: state.brightness == Brightness.light
                          ? const Color.fromARGB(255, 203, 232, 255)
                          : Colors.grey.shade800,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          color: Colors.white,
                          child: CachedNetworkImage(
                            imageUrl: item.image,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width * 0.25,
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              item.productName,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        SizedBox(width: 50, child: Text("\$${item.price}")),
                        IconButton(
                            onPressed: () => context.read<FavoritesBloc>().add(
                                RemoveFromFavsEvent(productId: item.productId)),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
