part of 'user_history_bloc.dart';

sealed class UserHistoryState extends Equatable {
  const UserHistoryState();

  @override
  List<Object> get props => [];
}

final class UserHistoryInitial extends UserHistoryState {}

//................................................ User History states
final class UserHistoryLoading extends UserHistoryState {}

final class UserHistorySuccess extends UserHistoryState {
  final List<HistoryEntity> userHistory;

  const UserHistorySuccess(this.userHistory);

  @override
  List<Object> get props => [super.props, userHistory];
}

final class UserHistoryError extends UserHistoryState {
  final String errMessage;

  const UserHistoryError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}
