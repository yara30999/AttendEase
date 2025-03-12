part of 'current_user_join_group_cubit.dart';

sealed class CurrentUserJoinGroupState extends Equatable {
  const CurrentUserJoinGroupState();

  @override
  List<Object> get props => [];
}

final class CurrentUserJoinGroupInitial extends CurrentUserJoinGroupState {}

final class CurrentUserJoinGroupLoading extends CurrentUserJoinGroupState {}

final class CurrentUserJoinGroupSuccess extends CurrentUserJoinGroupState {}

final class CurrentUserJoinGroupError extends CurrentUserJoinGroupState {
  final String errMessage;

  const CurrentUserJoinGroupError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}