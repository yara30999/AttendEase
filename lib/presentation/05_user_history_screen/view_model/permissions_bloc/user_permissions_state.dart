part of 'user_permissions_bloc.dart';

sealed class UserPermissionsState extends Equatable {
  const UserPermissionsState();

  @override
  List<Object> get props => [];
}

final class UserPermissionsInitial extends UserPermissionsState {}

//................................................ User permissions states
final class UserPermissionsLoading extends UserPermissionsState {}

final class UserPermissionsSuccess extends UserPermissionsState {
  final List<PermissionEntity> userPermissions;

  const UserPermissionsSuccess(this.userPermissions);

  @override
  List<Object> get props => [super.props, userPermissions];
}

final class UserPermissionsError extends UserPermissionsState {
  final String errMessage;

  const UserPermissionsError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}
