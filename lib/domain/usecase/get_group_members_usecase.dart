import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../entities/auth_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetGroupMembersUsecase
    implements BaseUseCase<String, List<AuthenticationEntity>> {
  final Repository _repository;

  GetGroupMembersUsecase(this._repository);

  @override
  Future<Either<Failure, List<AuthenticationEntity>>> execute([
    String? input,
  ]) async {
    return await _repository.getGroupMembers(input!);
  }
}
