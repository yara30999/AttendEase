part of 'delete_group_cubit.dart';

sealed class DeleteGroupState extends Equatable {
  const DeleteGroupState();

  @override
  List<Object> get props => [];
}

final class DeleteGroupInitial extends DeleteGroupState {}

class DeleteGroupLoading extends DeleteGroupState {}

class DeleteGroupSuccess extends DeleteGroupState {}

class DeleteGroupError extends DeleteGroupState {
  final String message;
  const DeleteGroupError(this.message);

  @override
  List<Object> get props => [super.props, message];
}
