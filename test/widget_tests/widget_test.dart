// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc_online_shop/Config/Theme/Theme_Cubit/cubit/theme_cubit.dart';
import 'package:bloc_online_shop/Core/DI/locator.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/sign_up_bloc/bloc/sign_up_bloc.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:bloc_online_shop/Features/Favorites/Presentation/Blocs/bloc/favorites_bloc.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Pages/home_screen.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/blocs/product_bloc/bloc/product_bloc.dart';
import 'package:bloc_online_shop/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_online_shop/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() async {
  if (Platform.environment.containsKey('CI')) {
    return;
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  late ThemeCubit themeCubit;
  late CartBloc cartBloc;
  late FavoritesBloc favoritesBloc;
  late AuthenticationBloc authenticationBloc;
  late LoginBloc loginBloc;
  late SignUpBloc signUpBloc;
  late ProductBloc productBloc;

  group('Authentication', () {
    setUp(() async {
      await setup();
      themeCubit = ThemeCubit();
      cartBloc = CartBloc(locator());
      favoritesBloc = FavoritesBloc(locator());
      authenticationBloc = AuthenticationBloc(locator());
      loginBloc = LoginBloc(locator());
      signUpBloc = SignUpBloc(locator());
      productBloc = ProductBloc(locator());
    });

    testWidgets(
      'Verify login',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<ThemeCubit>.value(value: themeCubit),
              BlocProvider<CartBloc>.value(value: cartBloc),
              BlocProvider<FavoritesBloc>.value(value: favoritesBloc),
              BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
              BlocProvider<LoginBloc>.value(value: loginBloc),
              BlocProvider<SignUpBloc>.value(value: signUpBloc),
              BlocProvider<ProductBloc>.value(value: productBloc),
            ],
            child: const app.MyApp(),
          ),
        );
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 2));
        tester.enterText(find.byKey(const Key('email_field')),
            'aminmusic.original1@gmail.com');
        await Future.delayed(const Duration(seconds: 2));
        tester.enterText(find.byKey(const Key('password_field')), '123456');
        await Future.delayed(const Duration(seconds: 2));
        await tester.tap(find.byKey(const Key('loginButton')));
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsOneWidget);
      },
    );
  }, skip: true);
}
