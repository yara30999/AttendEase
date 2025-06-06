import 'package:dartz/dartz.dart';
import '../../app/app_prefs.dart';
import '../../app/extensions.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/group_entity.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/entities/permission_entity.dart';
import '../../domain/repository/repository.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../mappers/mappers.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../network/requests.dart';
import '../responses/group_response.dart';
import '../responses/history_response.dart';
import '../responses/permission_response.dart';
import '../responses/user_response.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;
  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._localDataSource,
    this._appPreferences,
  );

  @override
  Future<Either<Failure, AuthenticationEntity>> login(
    LoginRequest loginRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final UserResponse authResponse = await _remoteDataSource.login(
          loginRequest,
        );
        await _localDataSource.saveUserDataToCache(authResponse.toDomain());
        await _appPreferences.setUserLoggedIn();
        if (authResponse.role == Role.admin.name) {
          await _appPreferences.setUserRole(Role.admin);
        } else {
          await _appPreferences.setUserRole(Role.user);
        }
        return Right(authResponse.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> register(
    RegisterRequest registerRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.register(registerRequest);
        return const Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.forgotPassword(email);
        return const Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.logout();
        await _localDataSource.clearAllCachedBoxes();
        await _appPreferences.removePrefs();
        return const Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createGroup(
    CreateGroupRequest createGroupRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.createGroup(createGroupRequest);
        return const Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Stream<List<GroupEntity>> getGroups() {
    return _remoteDataSource.getGroups().map((groupResponses) {
      // Map each groupResponse to groupEntity
      return groupResponses
          .map((groupResponse) => groupResponse.toDomain())
          .toList();
    });
  }

  @override
  Stream<String?> getCurrentUserGroupId() {
    return _remoteDataSource.getCurrentUserGroupId();
  }

  @override
  Stream<List<AuthenticationEntity>> getGroupMembersStream(String groupId) {
    return _remoteDataSource.getGroupMembersStream(groupId).map((
      membersResponses,
    ) {
      // Map each userResponse to AuthenticationEntity
      return membersResponses
          .map((memberResponse) => memberResponse.toDomain())
          .toList();
    });
  }

  @override
  Future<Either<Failure, GroupEntity>> getGroupInfo(String groupId) async {
    if (await _networkInfo.isConnected) {
      try {
        final GroupResponse groupResponse = await _remoteDataSource
            .getGroupInfo(groupId);
        return Right(groupResponse.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<AuthenticationEntity>>> getGroupMembers(
    String groupId,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final List<UserResponse> userResponses = await _remoteDataSource
            .getGroupMembers(groupId);
        if (userResponses.isEmpty) {
          return Right([]);
        }
        // else map responses to entities...
        final List<AuthenticationEntity> authEntities =
            userResponses.map((user) => user.toDomain()).toList();
        return Right(authEntities);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<HistoryEntity>>> getUserHistory(
    String userId,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final List<HistoryResponse> historyResponses = await _remoteDataSource
            .getUserHistory(userId);
        if (historyResponses.isEmpty) {
          return Right([]);
        }
        // else map responses to entities...
        final List<HistoryEntity> historyEntities =
            historyResponses.map((history) => history.toDomain()).toList();
        return Right(historyEntities);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<PermissionEntity>>> getUserPermissions(
    String userId,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final List<PermissionResponse> permissionResponses =
            await _remoteDataSource.getUserPermissions(userId);
        if (permissionResponses.isEmpty) {
          return Right([]);
        }
        // else map responses to entities...
        final List<PermissionEntity> permissionEntities =
            permissionResponses
                .map((permission) => permission.toDomain())
                .toList();
        return Right(permissionEntities);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUserFromGroup(String userId) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.deleteUserFromGroup(userId);
        return Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteGroup(String groupId) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.deleteGroup(groupId);
        return Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> currentUserjoinGroup(String groupId) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.currentUserjoinGroup(groupId);
        return Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> currentUserCheckIn(
    CheckInRequest checkInRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.currentUserCheckIn(checkInRequest);
        return Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> currentUserCheckOut(
    CheckOutRequest checkOutRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.currentUserCheckOut(checkOutRequest);
        return Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> currentUserTakePermission(
    PermissionRequest permissionRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.currentUserTakePermission(permissionRequest);
        return Right(true);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> canUserCheckInOrHavePermissionToday(
    String groupId,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final bool canHaveAction = await _remoteDataSource
            .canUserCheckInOrHavePermissionToday(groupId);
        return Right(canHaveAction);
      } catch (error) {
        return Left(Failure(400, error.toString()));
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
