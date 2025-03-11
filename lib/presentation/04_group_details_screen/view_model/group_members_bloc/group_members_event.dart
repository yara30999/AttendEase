part of 'group_members_bloc.dart';

sealed class GroupMembersEvent extends Equatable {
  const GroupMembersEvent();

  @override
  List<Object> get props => [];
}

class GroupMembersRequested extends GroupMembersEvent {
  final String groupId;

  GroupMembersRequested({
    required this.groupId,
  });

  @override
  List<Object> get props => [
    super.props,
    groupId,
  ];
}
