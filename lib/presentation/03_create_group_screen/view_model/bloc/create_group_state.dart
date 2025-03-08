part of 'create_group_bloc.dart';

sealed class CreateGroupState extends Equatable {
  const CreateGroupState();

  @override
  List<Object> get props => [];
}

final class CreateGroupInitial extends CreateGroupState {}

//................................................ Create Group states
final class CreateGroupLoading extends CreateGroupState {}

final class CreateGroupSuccess extends CreateGroupState {}

final class CreateGroupError extends CreateGroupState {
  final String errMessage;

  const CreateGroupError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}
