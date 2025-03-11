import '../repository/repository.dart';

class CurrentUserGroupIdStream {
  final Repository _repository;

  CurrentUserGroupIdStream(this._repository);

  Stream<String?> execute() {
    return _repository.getCurrentUserGroupId();
  }
}
