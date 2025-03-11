import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DeleteUserFromGroupUsecase implements BaseUseCase<String, bool> {
  final Repository _repository;

  DeleteUserFromGroupUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute([String? input]) async {
    return await _repository.deleteUserFromGroup(input!);
  }
}
