// ignore_for_file: use_build_context_synchronously

import 'package:bloc_online_shop/Core/DI/locator.dart';
import 'package:bloc_online_shop/Core/Utils/UserAuth_Check/user_auth.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Pages/authentication_screen.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:bloc_online_shop/Features/Categories/Presentation/Pages/categories_screen.dart';
import 'package:bloc_online_shop/Features/Favorites/Presentation/Blocs/bloc/favorites_bloc.dart';
import 'package:bloc_online_shop/Features/Order/Presentation/Blocs/order_bloc/bloc/order_bloc.dart';
import 'package:bloc_online_shop/Features/Order/Presentation/Pages/order_screen.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Cubits/Notifications/notifications_cubit.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Pages/bottom_nav_cubit.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Pages/main_wrapper.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String initPage = '/init';
  static const String orderPage = '/order';
  static const String categoriesPage = '/categories';
  static const String favoritesPage = '/favorites';

  static GoRouter router = GoRouter(initialLocation: initPage, routes: [
    GoRoute(
      path: initPage,
      builder: (context, state) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            UserAuth.userId = FirebaseAuth.instance.currentUser!.uid;
            context.read<CartBloc>().add(FetchCartStreamEvent(UserAuth.userId));
            context
                .read<FavoritesBloc>()
                .add(FetchFavStreamEvent(UserAuth.userId));
            return MultiBlocProvider(
              providers: [
                BlocProvider<BottomNavCubit>(create: (_) => BottomNavCubit()),
                BlocProvider<NotificationCubit>(
                    create: (context) => NotificationCubit()),
                BlocProvider<SearchBloc>(
                    create: (context) => SearchBloc(locator())),
              ],
              child: const MainWrapper(),
            );
          } else {
            return const AuthenticationScreen();
          }
        });
      },
    ),
    GoRoute(
      path: orderPage,
      builder: (context, state) {
        final productId = state.extra as int;
        return BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(locator(), locator()),
          child: OrderScreen(
            productId: productId,
          ),
        );
      },
    ),
    GoRoute(
        path: categoriesPage,
        builder: (context, state) {
          final category = state.extra as String;
          return CategoriesScreen(
            category: category,
          );
        }),
  ]);
}
