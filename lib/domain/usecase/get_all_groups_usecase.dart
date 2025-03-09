import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../entities/group_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetAllGroupsUsecase implements BaseUseCase<void, List<GroupEntity>> {
  final Repository _repository;

  GetAllGroupsUsecase(this._repository);

  @override
  Future<Either<Failure, List<GroupEntity>>> execute([void _]) async {
    return await _repository.getAllGroups();
  }
}

class GetGroupDetailsUseCaseInput {
  final String id;

  GetGroupDetailsUseCaseInput(
    this.id,
  );
}
