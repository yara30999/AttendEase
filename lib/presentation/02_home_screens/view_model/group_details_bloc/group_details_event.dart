part of 'group_details_bloc.dart';

sealed class GroupDetailsEvent extends Equatable {
  const GroupDetailsEvent();

  @override
  List<Object> get props => [];
}

class GroupDetailsRequested extends GroupDetailsEvent {
  final String groupId;

  GroupDetailsRequested({
    required this.groupId,
  });

  @override
  List<Object> get props => [
    super.props,
    groupId,
  ];
}
