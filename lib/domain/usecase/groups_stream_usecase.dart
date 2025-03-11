import '../entities/group_entity.dart';
import '../repository/repository.dart';

class GroupsStreamUsecase {
  final Repository _repository;

  GroupsStreamUsecase(this._repository);

  Stream<List<GroupEntity>> execute() {
    return _repository.getGroups();
  }
}
