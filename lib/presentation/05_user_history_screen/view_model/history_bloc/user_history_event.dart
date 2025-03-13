part of 'user_history_bloc.dart';

sealed class UserHistoryEvent extends Equatable {
  UserHistoryEvent();

  @override
  List<Object> get props => [];
}

class UserHistoryEventRequested extends UserHistoryEvent {
  final String userId;

  UserHistoryEventRequested(this.userId);

  @override
  List<Object> get props => [super.props, userId];
}
