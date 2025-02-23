import 'package:bloc_online_shop/Features/Authentication/Data/Models/user_model.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class SignUpParams {
  final UserModel myUser;
  final String password;

  SignUpParams({required this.myUser, required this.password});
}
