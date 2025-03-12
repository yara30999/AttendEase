import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CurrentUserJoinGroupUsecase implements BaseUseCase<String, bool> {
  final Repository _repository;

  CurrentUserJoinGroupUsecase(this._repository);

  // input is the group id
  @override
  Future<Either<Failure, bool>> execute([String? input]) async {
    return await _repository.currentUserjoinGroup(input!);
  }
}
