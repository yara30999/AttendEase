import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DeleteGroupUsecase implements BaseUseCase<String, bool> {
  final Repository _repository;

  DeleteGroupUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute([String? input]) async {
    return await _repository.deleteGroup(input!);
  }
}
