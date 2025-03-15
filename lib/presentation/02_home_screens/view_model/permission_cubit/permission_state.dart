part of 'permission_cubit.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => [];
}

final class PermissionInitial extends PermissionState {}

class PermissionLoading extends PermissionState {}

class PermissionSuccess extends PermissionState {}

class PermissionError extends PermissionState {
  final String message;
  const PermissionError(this.message);

  @override
  List<Object> get props => [super.props, message];
}
