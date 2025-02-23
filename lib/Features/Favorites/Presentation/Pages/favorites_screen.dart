import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Favorites/Presentation/Blocs/bloc/favorites_bloc.dart';
import 'package:bloc_online_shop/Features/Favorites/Presentation/Widgets/fav_items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavsLoadingState) {
              return const Center(child: spinkit);
            } else if (state is FavsErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is FavsLoadedState) {
              if (state.favProducts.isEmpty) {
                return const Center(
                  child: Text('Empty'),
                );
              }
              return FavItemsList(state: state);
            }
            return const SizedBox.shrink();
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
