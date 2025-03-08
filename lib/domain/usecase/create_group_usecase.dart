import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CreateGroupUsecase implements BaseUseCase<CreateGroupUseCaseInput, bool> {
  final Repository _repository;

  CreateGroupUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute([
    CreateGroupUseCaseInput? input,
  ]) async {
    return await _repository.createGroup(
      CreateGroupRequest(
        input!.name,
        input.checkIn,
        input.checkOut,
        input.days,
        input.location,
      ),
    );
  }
}

class CreateGroupUseCaseInput {
  final String name;
  final DateTime checkIn;
  final DateTime checkOut;
  final List<int> days;
  final GeoPoint location;

  CreateGroupUseCaseInput(
    this.name,
    this.checkIn,
    this.checkOut,
    this.days,
    this.location,
  );
}
