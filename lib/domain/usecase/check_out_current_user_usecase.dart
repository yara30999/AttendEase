import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CheckOutCurrentUser implements BaseUseCase<CheckOutUsecaseInput, bool> {
  final Repository _repository;

  CheckOutCurrentUser(this._repository);

  @override
  Future<Either<Failure, bool>> execute([CheckOutUsecaseInput? input]) async {
    return await _repository.currentUserCheckOut(
      CheckOutRequest(input!.docId, input.groupId, input.checkOut),
    );
  }
}

class CheckOutUsecaseInput {
  final String docId;
  final String groupId;
  final DateTime checkOut;

  CheckOutUsecaseInput(this.docId, this.groupId, this.checkOut);
}
