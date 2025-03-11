part of 'group_members_bloc.dart';

sealed class GroupMembersState extends Equatable {
  const GroupMembersState();

  @override
  List<Object> get props => [];
}

final class GroupMembersInitial extends GroupMembersState {}

//................................................ Group Members states
final class GroupMembersLoading extends GroupMembersState {}

final class GroupMembersSuccess extends GroupMembersState {
  final List<AuthenticationEntity> groupMembers;

  const GroupMembersSuccess(this.groupMembers);

  @override
  List<Object> get props => [super.props, groupMembers];
}

final class GroupDetailsError extends GroupMembersState {
  final String errMessage;

  const GroupDetailsError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}
