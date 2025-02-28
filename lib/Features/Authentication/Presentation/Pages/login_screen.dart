import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Pages/Widgets/text_field_1.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Pages/Widgets/Top_Snack_bar/top_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/password_cubit/cubit/password_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.errorMsg});

  final String? errorMsg;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AutomaticKeepAliveClientMixin {
  late final passwordController = TextEditingController();

  late final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Form(
            key: _formKey,
            child: Column(spacing: 10, children: [
              SizedBox(
                width: width * 0.9,
                height: 80,
                child: TextField1(
                  key: const Key('email_field'),
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Icon(
                      CupertinoIcons.mail_solid,
                      color: Colors.black,
                    ),
                  ),
                  errorMsg: widget.errorMsg,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter Email';
                    } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(val)) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: width * 0.9,
                height: 80,
                child: BlocBuilder<PasswordCubit, bool>(
                  builder: (context, state) {
                    return TextField1(
                      key: const Key('password_field'),
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: state,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Icon(
                          CupertinoIcons.lock_fill,
                          color: Colors.black,
                        ),
                      ),
                      errorMsg: widget.errorMsg,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<PasswordCubit>()
                                .togglePasswordVisibility();
                          },
                          icon: Icon(
                            state
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            size: 22,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
                return SizedBox(
                  width: width * 0.3,
                  child: TextButton(
                      key: const Key('loginButton'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(LoginRequired(
                              emailController.text, passwordController.text));
                        }
                      },
                      style: TextButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: state is LoginProcess
                            ? whiteLoadingSpinkit
                            : const SizedBox(
                                height: 25,
                                width: 50,
                                child: Center(
                                  child: Text(
                                    'Login',
                                  ),
                                ),
                              ),
                      )),
                );
              }, listener: (context, state) {
                if (state is LoginFailure) {
                  showTopSnackBar(
                    context,
                    state.message ?? 'Unknown Error',
                  );
                }
              }),
              const SizedBox(
                height: 30,
              )
            ])),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
