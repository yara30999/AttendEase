import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LogoutUsecase implements BaseUseCase<void, bool> {
  final Repository _repository;

  LogoutUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute([void input]) async {
    return await _repository.logout();
  }
}
