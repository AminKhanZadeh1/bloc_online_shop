import 'package:bloc_online_shop/Features/Authentication/Data/Repository/user_repo_impl.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/Repository/user_repo.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/UseCases/auth_use_cases.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/sign_up_bloc/bloc/sign_up_bloc.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:bloc_online_shop/Features/Favorites/Data/Repository/fav_repo_impl.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Repository/fav_repo.dart';
import 'package:bloc_online_shop/Features/Favorites/Presentation/Blocs/bloc/favorites_bloc.dart';
import 'package:bloc_online_shop/Features/Order/Presentation/Blocs/order_bloc/bloc/order_bloc.dart';
import 'package:bloc_online_shop/Features/Products/Data/Repository/product_repo_impl.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Repository/product_repo.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/blocs/product_bloc/bloc/product_bloc.dart';
import 'package:bloc_online_shop/Features/Search/Data/Repository/search_repo_impl.dart';
import 'package:bloc_online_shop/Features/Search/Domain/Repository/search_repo.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_bloc.dart';
import 'package:bloc_online_shop/Features/Cart/Data/Repository/cart_repo_impl.dart';
import 'package:bloc_online_shop/Features/Cart/Domain/Repository/cart_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

setup() {
  // Authentication Feature Dependencies

  // Repository
  locator.registerLazySingleton<UserRepo>(() => UserRepoImpl());

  // UseCases
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));

  locator.registerLazySingleton<LogOutUseCase>(() => LogOutUseCase(locator()));

  locator.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(locator()));

  // Bloc
  locator.registerLazySingleton<AuthenticationBloc>(
      () => AuthenticationBloc(locator()));

  locator.registerLazySingleton<LoginBloc>(() => LoginBloc(locator()));

  locator.registerLazySingleton<SignUpBloc>(() => SignUpBloc(locator()));

  // Product Feature Dependencies

  // Repository
  locator.registerLazySingleton<ProductRepo>(() => ProductRepoImpl());

  locator.registerLazySingleton<ProductBloc>(() => ProductBloc(locator()));

  // Search Feature Dependencies

  // Repository
  locator.registerLazySingleton<SearchRepo>(() => SearchRepoImpl());

  locator.registerLazySingleton<SearchBloc>(() => SearchBloc(locator()));

  // Cart & Order Feature Dependencies

  // Repository
  locator.registerLazySingleton<CartRepo>(() => CartRepoImpl());

  locator.registerLazySingleton<CartBloc>(() => CartBloc(locator()));

  locator
      .registerLazySingleton<OrderBloc>(() => OrderBloc(locator(), locator()));

  // Favorites Feature Dependencies

  // Repository
  locator.registerLazySingleton<FavRepo>(
    () => FavRepoImpl(),
  );

  locator.registerLazySingleton<FavoritesBloc>(
    () => FavoritesBloc(locator()),
  );
}
