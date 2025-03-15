import 'package:dartz/dartz.dart';
import '../../app/extensions.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CurrentUserTakePermissionUsecase
    implements BaseUseCase<PermissionUsecaseInput, bool> {
  final Repository _repository;

  CurrentUserTakePermissionUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute([PermissionUsecaseInput? input]) async {
    return await _repository.currentUserTakePermission(
      PermissionRequest(
        input!.groupId,
        input.time,
        input.type.name,
        input.message,
      ),
    );
  }
}

class PermissionUsecaseInput {
  final String groupId;
  final DateTime time;
  final PermissionType type;
  final String? message;

  PermissionUsecaseInput(this.groupId, this.time, this.type, this.message);
}
