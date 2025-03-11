import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../entities/history_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetUserHistoryUsecase
    implements BaseUseCase<String, List<HistoryEntity>> {
  final Repository _repository;

  GetUserHistoryUsecase(this._repository);

  @override
  Future<Either<Failure, List<HistoryEntity>>> execute([String? input]) async {
    return await _repository.getUserHistory(input!);
  }
}
