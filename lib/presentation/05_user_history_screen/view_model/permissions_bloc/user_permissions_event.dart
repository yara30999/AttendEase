part of 'user_permissions_bloc.dart';

sealed class UserPermissionsEvent extends Equatable {
  UserPermissionsEvent();

  @override
  List<Object> get props => [];
}

class UserPermissionsEventRequested extends UserPermissionsEvent {
  final String userId;

  UserPermissionsEventRequested(this.userId);

  @override
  List<Object> get props => [super.props, userId];
}
