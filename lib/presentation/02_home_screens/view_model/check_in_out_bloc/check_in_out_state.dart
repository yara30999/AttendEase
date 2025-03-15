part of 'check_in_out_bloc.dart';

sealed class CheckInOutState extends Equatable {
  final CheckStatus checkStatus;
  final DateTime? checkInTime;
  const CheckInOutState(this.checkStatus, this.checkInTime);

  @override
  List<Object> get props => [];
}

final class CheckInOutInitial extends CheckInOutState {
  CheckInOutInitial(super.checkStatus, super.checkInTime);
}

//................................................ check in out states
final class CheckInOutLoading extends CheckInOutState {
  CheckInOutLoading(super.checkStatus, super.checkInTime);
}

final class CheckInOutSuccess extends CheckInOutState {
  CheckInOutSuccess(super.checkStatus, super.checkInTime);
}

final class CheckInOutError extends CheckInOutState {
  final String errMessage;
  CheckInOutError(super.checkStatus, super.checkInTime, this.errMessage);
}
