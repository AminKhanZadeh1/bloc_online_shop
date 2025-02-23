import 'package:bloc/bloc.dart';
import 'package:bloc_online_shop/Features/Authentication/Data/Models/user_model.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/Repository/user_repo.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/UseCases/Params/auth_params.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/UseCases/auth_use_cases.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepo _userRepository;

  SignUpBloc(this._userRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        await SignUpUseCase(_userRepository)
            .call(SignUpParams(myUser: event.user, password: event.password));
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(message: e.toString()));
      }
    });
  }
}
