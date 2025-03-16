import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CanUserHaveActionTodayUsecase implements BaseUseCase<String, bool> {
  final Repository _repository;

  CanUserHaveActionTodayUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute([String? input]) async {
    return await _repository.canUserCheckInOrHavePermissionToday(input!);
  }
}
