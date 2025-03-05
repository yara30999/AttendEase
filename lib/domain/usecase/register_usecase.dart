import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUsecase implements BaseUseCase<RegisterUseCaseInput, bool> {
  final Repository _repository;

  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute([RegisterUseCaseInput? input]) async {
    //we can handle some permesions here in each usecase before execute the repo methods.
    return await _repository.register(
      RegisterRequest(input!.userName, input.email, input.password, input.role),
    );
  }
}

class RegisterUseCaseInput {
  String userName;
  String email;
  String password;
  String role;

  RegisterUseCaseInput(this.userName, this.email, this.password, this.role);
}
