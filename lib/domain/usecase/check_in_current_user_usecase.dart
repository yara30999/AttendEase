import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CheckInCurrentUser implements BaseUseCase<CheckInUsecaseInput, bool> {
  final Repository _repository;

  CheckInCurrentUser(this._repository);

  @override
  Future<Either<Failure, bool>> execute([CheckInUsecaseInput? input]) async {
    return await _repository.currentUserCheckIn(
      CheckInRequest(input!.docId, input.groupId, input.checkIn),
    );
  }
}

class CheckInUsecaseInput {
  final String docId;
  final String groupId;
  final DateTime checkIn;

  CheckInUsecaseInput(this.docId, this.groupId, this.checkIn);
}
