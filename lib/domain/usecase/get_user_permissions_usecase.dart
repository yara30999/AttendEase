import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../entities/permission_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetUserPermissionsUsecase
    implements BaseUseCase<String, List<PermissionEntity>> {
  final Repository _repository;

  GetUserPermissionsUsecase(this._repository);

  @override
  Future<Either<Failure, List<PermissionEntity>>> execute([
    String? input,
  ]) async {
    return await _repository.getUserPermissions(input!);
  }
}
