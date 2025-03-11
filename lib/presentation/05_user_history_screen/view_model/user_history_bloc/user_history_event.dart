part of 'user_history_bloc.dart';

sealed class UserHistoryEvent extends Equatable {
  const UserHistoryEvent();

  @override
  List<Object> get props => [];
}

class UserHistoryRequested extends UserHistoryEvent {
  final String userId;

  UserHistoryRequested({
    required this.userId,
  });

  @override
  List<Object> get props => [
    super.props,
    userId,
  ];
}
