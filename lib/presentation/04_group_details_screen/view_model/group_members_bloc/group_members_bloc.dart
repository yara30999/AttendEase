import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/auth_entity.dart';
import '../../../../domain/usecase/get_group_members_usecase.dart';
part 'group_members_event.dart';
part 'group_members_state.dart';

class GroupMembersBloc extends Bloc<GroupMembersEvent, GroupMembersState> {
  final GetGroupMembersUsecase _groupMembersUsecase;

  String? _errMessage;
  List<AuthenticationEntity>? groupMembers;

  GroupMembersBloc(this._groupMembersUsecase) : super(GroupMembersInitial()) {
    on<GroupMembersRequested>(onGroupMembersRequested);
  }

  FutureOr<void> onGroupMembersRequested(
    GroupMembersRequested event,
    Emitter<GroupMembersState> emit,
  ) async {
    emit(GroupMembersLoading());
    var result = await _groupMembersUsecase.execute(event.groupId);
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(GroupMembersError(_errMessage!));
      },
      (groupMembers) {
        emit(GroupMembersSuccess(groupMembers));
      },
    );
  }
}
