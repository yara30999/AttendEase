import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/auth_entity.dart';
import '../../../../domain/usecase/group_members_stream_usecase.dart';

part 'group_members_state.dart';

class GroupMembersCubit extends Cubit<GroupMembersState> {
  final GroupMembersStreamUsecase _groupMembersStreamUsecase;
  String? _errMessage;
  GroupMembersCubit(this._groupMembersStreamUsecase)
    : super(GroupMembersInitial());

  void getStreamMembers(String groupId) {
    emit(GroupMembersLoading());
    _groupMembersStreamUsecase
        .execute(groupId)
        .listen(
          (members) {
            emit(GroupMembersSuccess(members));
          },
          onError: (error) {
            _errMessage =
                '${error.message.toString()} ${error.code.toString()}';
            emit(GroupMembersError(_errMessage!));
          },
        );
  }
}
