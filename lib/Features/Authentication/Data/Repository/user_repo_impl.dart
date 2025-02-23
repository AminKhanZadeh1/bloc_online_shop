import 'package:bloc_online_shop/Core/Utils/Failures/Authentication%20Errors/auth_errors.dart';
import 'package:bloc_online_shop/Features/Authentication/Data/Models/user_model.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/Repository/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepoImpl implements UserRepo {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  UserRepoImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw AuthErrors.fromErrorCode(e.code).message;
      } else {
        throw e.toString();
      }
    }
  }

  @override
  Future<UserModel> signUp(UserModel myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(userId: user.user!.uid);

      return myUser;
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw AuthErrors.fromErrorCode(e.code).message;
      } else {
        throw e.toString();
      }
    }
  }

  @override
  Future<void> setUserData(UserModel user) async {
    try {
      await usersCollection.doc(user.userId).set(user.toEntity().toDocument);
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw AuthErrors.fromErrorCode(e.code).message;
      } else {
        throw e.toString();
      }
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw AuthErrors.fromErrorCode(e.code).message;
      } else {
        throw e.toString();
      }
    }
  }
}
