part of 'join_group_cubit.dart';

sealed class JoinGroupState extends Equatable {
  const JoinGroupState();

  @override
  List<Object> get props => [];
}

final class JoinGroupInitial extends JoinGroupState {}

class JoinGroupLoading extends JoinGroupState {}

class JoinGroupSuccess extends JoinGroupState {}

class JoinGroupError extends JoinGroupState {
  final String message;
  const JoinGroupError(this.message);

  @override
  List<Object> get props => [super.props, message];
}
