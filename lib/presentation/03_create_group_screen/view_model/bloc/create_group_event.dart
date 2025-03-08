part of 'create_group_bloc.dart';

sealed class CreateGroupEvent extends Equatable {
  const CreateGroupEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupRequested extends CreateGroupEvent {
  final String groupName;
  final List<int> days;
  final TimeOfDay checkInTime;
  final TimeOfDay checkOutTime;

  CreateGroupRequested({
    required this.groupName,
    required this.days,
    required this.checkInTime,
    required this.checkOutTime,
  });

  @override
  List<Object> get props => [
    super.props,
    groupName,
    days,
    checkInTime,
    checkOutTime,
  ];
}
