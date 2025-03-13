part of 'group_members_cubit.dart';

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

final class GroupMembersError extends GroupMembersState {
  final String message;

  const GroupMembersError(this.message);

  @override
  List<Object> get props => [super.props, message];
}
