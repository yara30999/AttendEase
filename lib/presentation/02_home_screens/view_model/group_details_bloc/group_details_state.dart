part of 'group_details_bloc.dart';

sealed class GroupDetailsState extends Equatable {
  const GroupDetailsState();

  @override
  List<Object> get props => [];
}

final class GroupDetailsInitial extends GroupDetailsState {}

//................................................ Group Details states
final class GroupDetailsLoading extends GroupDetailsState {}

final class GroupDetailsSuccess extends GroupDetailsState {
  final GroupEntity groupEntity;

  const GroupDetailsSuccess(this.groupEntity);

  @override
  List<Object> get props => [super.props, groupEntity];
}

final class GroupDetailsError extends GroupDetailsState {
  final String errMessage;

  const GroupDetailsError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}
