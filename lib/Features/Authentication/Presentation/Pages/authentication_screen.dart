import 'dart:ui';
import 'package:bloc_online_shop/Core/DI/locator.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/sign_up_bloc/bloc/sign_up_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Cubits/password_cubit/cubit/password_cubit.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Pages/login_screen.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Pages/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: height,
                  width: width / 1.3,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 255, 143, 181),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: height,
                width: width / 1.3,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container()),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor: Colors.grey[600],
                          labelColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                          child: MultiBlocProvider(
                        providers: [
                          BlocProvider<SignUpBloc>(
                            create: (context) => SignUpBloc(locator()),
                          ),
                          BlocProvider<PasswordCubit>(
                            create: (context) => PasswordCubit(),
                          ),
                        ],
                        child: TabBarView(
                            physics: const ClampingScrollPhysics(),
                            controller: tabController,
                            children: const [LoginScreen(), SignUpScreen()]),
                      ))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
