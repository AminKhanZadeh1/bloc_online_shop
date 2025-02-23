part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final User? user;

  const AuthenticationStatusChanged(this.user);
}

class TogglePasswordVisibility extends AuthenticationEvent {}
