import 'package:bloc_online_shop/Features/Authentication/Data/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepo {
  Stream<User?> get user;

  Future<UserModel> signUp(UserModel myUser, String password);

  Future<void> setUserData(UserModel user);

  Future<void> login(String email, String password);

  Future<void> logOut();
}
