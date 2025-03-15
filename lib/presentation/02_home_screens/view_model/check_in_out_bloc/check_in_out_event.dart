part of 'check_in_out_bloc.dart';

sealed class CheckInOutEvent extends Equatable {
  const CheckInOutEvent();

  @override
  List<Object> get props => [];
}

class CheckInRequested extends CheckInOutEvent {
  final GroupEntity groupEntity;

  CheckInRequested({required this.groupEntity});

  @override
  List<Object> get props => [super.props, groupEntity];
}

class CheckOutRequested extends CheckInOutEvent {
  final GroupEntity groupEntity;

  CheckOutRequested({required this.groupEntity});

  @override
  List<Object> get props => [super.props, groupEntity];
}
