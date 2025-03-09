import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../entities/group_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetGroupDetailsUsecase implements BaseUseCase<String, GroupEntity> {
  final Repository _repository;

  GetGroupDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, GroupEntity>> execute([String? id]) async {
    return await _repository.getGroupDetails(id!);
  }
}
