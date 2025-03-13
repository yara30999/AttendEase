part of 'delete_member_from_group_cubit.dart';

sealed class DeleteMemberFromGroupState extends Equatable {
  const DeleteMemberFromGroupState();

  @override
  List<Object> get props => [];
}

final class DeleteMemberInitial extends DeleteMemberFromGroupState {}

class DeleteMemberLoading extends DeleteMemberFromGroupState {}

class DeleteMemberSuccess extends DeleteMemberFromGroupState {}

class DeleteMemberError extends DeleteMemberFromGroupState {
  final String message;
  const DeleteMemberError(this.message);

  @override
  List<Object> get props => [super.props, message];
}
