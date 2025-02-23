import 'package:bloc_online_shop/Core/Utils/Params/params.dart';
import 'package:bloc_online_shop/Features/Authentication/Data/Models/user_model.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/Repository/user_repo.dart';
import 'package:bloc_online_shop/Features/Authentication/Domain/UseCases/Params/auth_params.dart';

//UseCases

class LoginUseCase implements UseCase<void, LoginParams> {
  final UserRepo userRepo;

  LoginUseCase(this.userRepo);

  @override
  Future<void> call(LoginParams params) async {
    await userRepo.login(params.email, params.password);
  }
}

class LogOutUseCase implements UseCase<void, void> {
  final UserRepo userRepo;

  LogOutUseCase(this.userRepo);

  @override
  Future<void> call(void params) async {
    await userRepo.logOut();
  }
}

class SignUpUseCase implements UseCase<UserModel, SignUpParams> {
  final UserRepo userRepo;

  SignUpUseCase(this.userRepo);

  @override
  Future<UserModel> call(SignUpParams params) async {
    UserModel user = await userRepo.signUp(params.myUser, params.password);
    await userRepo.setUserData(user);
    return user;
  }
}
