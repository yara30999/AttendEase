import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../entities/auth_entity.dart';
import '../entities/group_entity.dart';
import '../entities/history_entity.dart';
import '../entities/permission_entity.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationEntity>> login(
    LoginRequest loginRequest,
  );
  Future<Either<Failure, bool>> register(RegisterRequest registerRequest);
  Future<Either<Failure, bool>> forgotPassword(String email);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> createGroup(
    CreateGroupRequest createGroupRequest,
  );
  Stream<List<GroupEntity>> getGroups();
  Stream<String?> getCurrentUserGroupId();
  Stream<List<AuthenticationEntity>> getGroupMembersStream(String groupId);
  Future<Either<Failure, GroupEntity>> getGroupInfo(String groupId);
  Future<Either<Failure, List<AuthenticationEntity>>> getGroupMembers(
    String groupId,
  );
  Future<Either<Failure, List<HistoryEntity>>> getUserHistory(String userId);
  Future<Either<Failure, List<PermissionEntity>>> getUserPermissions(
    String userId,
  );
  Future<Either<Failure, bool>> deleteUserFromGroup(String userId);
  Future<Either<Failure, bool>> deleteGroup(String groupId);
  Future<Either<Failure, bool>> currentUserjoinGroup(String groupId);
  Future<Either<Failure, bool>> currentUserCheckIn(
    CheckInRequest checkInRequest,
  );
  Future<Either<Failure, bool>> currentUserCheckOut(
    CheckOutRequest checkOutRequest,
  );
  Future<Either<Failure, bool>> currentUserTakePermission(
    PermissionRequest permissionRequest,
  );
}
