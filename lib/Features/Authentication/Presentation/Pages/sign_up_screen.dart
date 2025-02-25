import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Authentication/Data/Models/user_model.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/sign_up_bloc/bloc/sign_up_bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Pages/Widgets/Top_Snack_bar/top_snack_bar.dart';
import 'package:bloc_online_shop/Features/Authentication/Presentation/Pages/Widgets/text_field_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/password_cubit/cubit/password_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, this.errorMsg});

  final String? errorMsg;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with AutomaticKeepAliveClientMixin {
  late final passwordController = TextEditingController();

  late final emailController = TextEditingController();

  late final nameController = TextEditingController();

  late final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool signUpRequired = false;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ColorScheme themeData = Theme.of(context).colorScheme;
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          signUpRequired = false;
        } else if (state is SignUpProcess) {
          signUpRequired = true;
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: ListView(
        children: [
          Form(
              key: _formKey,
              child: Column(spacing: 10, children: [
                SizedBox(
                  width: width * 0.9,
                  height: 80,
                  child: TextField1(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Icon(
                        CupertinoIcons.person_fill,
                        color: Colors.black,
                      ),
                    ),
                    errorMsg: widget.errorMsg,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: width * 0.9,
                  height: 80,
                  child: TextField1(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: state,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Icon(
                            CupertinoIcons.lock_fill,
                            color: Colors.black,
                          ),
                        ),
                        errorMsg: widget.errorMsg,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter Password';
                          } else if (val.length < 6) {
                            return 'Password must be at least 6 characters';
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
                SizedBox(
                  width: width * 0.9,
                  height: 80,
                  child: TextField1(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Icon(
                        CupertinoIcons.lock_shield_fill,
                        color: Colors.black,
                      ),
                    ),
                    errorMsg: widget.errorMsg,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter Confirm Password';
                      } else if (val != passwordController.text) {
                        return 'Your passwords don’t match. Please ensure both fields have the same password.';
                      }
                      return null;
                    },
                  ),
                ),
                BlocConsumer<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: width * 0.3,
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              UserModel user = UserModel.empty;
                              user = user.copyWith(
                                email: emailController.text,
                                name: nameController.text,
                              );
                              context.read<SignUpBloc>().add(SignUpRequired(
                                  user, passwordController.text));
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
                            child: state is SignUpProcess
                                ? loadingSpinkit
                                : const SizedBox(
                                    height: 25,
                                    width: 90,
                                    child: Center(
                                      child: Text(
                                        'Sign Up',
                                      ),
                                    ),
                                  ),
                          )),
                    );
                  },
                  listener: (context, state) {
                    if (state is SignUpFailure) {
                      showTopSnackBar(
                          context, state.message ?? 'Unknown Error');
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                )
              ])),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
