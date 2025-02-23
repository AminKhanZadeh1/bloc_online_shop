import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/Repository/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
export 'package:bloc_online_shop/main.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc(
    this.userRepository,
  ) : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationStatusChanged(user));
    });
    on<AuthenticationStatusChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
