import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../entities/group_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetGroupInfoUsecase implements BaseUseCase<String, GroupEntity> {
  final Repository _repository;

  GetGroupInfoUsecase(this._repository);

  @override
  Future<Either<Failure, GroupEntity>> execute([String? input]) async {
    return await _repository.getGroupInfo(input!);
  }
}
