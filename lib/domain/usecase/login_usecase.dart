import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../entities/auth_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

// in ===> LoginUseCaseInput
// out ===> Authentication
class LoginUseCase
    implements BaseUseCase<LoginUseCaseInput, AuthenticationEntity> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, AuthenticationEntity>> execute(
      [LoginUseCaseInput? input]) async {
    //we can handle some permesions here in each usecase before execute the repo methods.
    return await _repository.login(LoginRequest(input!.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
