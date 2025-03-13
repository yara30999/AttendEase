import '../entities/auth_entity.dart';
import '../repository/repository.dart';

class GroupMembersStreamUsecase {
  final Repository _repository;

  GroupMembersStreamUsecase(this._repository);

  Stream<List<AuthenticationEntity>> execute(String groupId) {
    return _repository.getGroupMembersStream(groupId);
  }
}
