import 'package:bloc_online_shop/Config/Theme/Theme_Cubit/cubit/theme_cubit.dart';
import 'package:bloc_online_shop/Config/l10n/l10n.dart';
import 'package:bloc_online_shop/Core/DI/locator.dart';
import 'package:bloc_online_shop/Core/Utils/Routes/routes.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:bloc_online_shop/Features/Cart/Presentation/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/blocs/product_bloc/bloc/product_bloc.dart';
import 'package:bloc_online_shop/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeCubit>(
        create: (context) => ThemeCubit(),
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(locator()),
      ),
      BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator())),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(locator()),
      ),
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(locator()),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp.router(
          title: 'Online Shop',
          theme: theme,
          routerConfig: Routes.router,
          debugShowCheckedModeBanner: false,
          supportedLocales: L10n.all,
          locale: const Locale('en'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
        );
      },
    );
  }
}
