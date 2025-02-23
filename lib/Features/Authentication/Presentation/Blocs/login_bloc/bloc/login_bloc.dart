import 'package:bloc/bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/Repository/user_repo.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/UseCases/Params/auth_params.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/UseCases/auth_use_cases.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepo _userRepository;
  LoginBloc(this._userRepository) : super(LoginInitial()) {
    on<LoginRequired>((event, emit) async {
      emit(LoginProcess());
      try {
        await LoginUseCase(_userRepository)
            .call(LoginParams(email: event.email, password: event.password));
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(message: e.toString()));
      }
    });
    on<LogOutRequest>(
      (event, emit) async {
        await LogOutUseCase(_userRepository).call(null);
      },
    );
  }
}
