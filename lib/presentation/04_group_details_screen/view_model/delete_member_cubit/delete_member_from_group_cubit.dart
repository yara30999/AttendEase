import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecase/delete_user_from_group_usecase.dart';

part 'delete_member_from_group_state.dart';

class DeleteMemberFromGroupCubit extends Cubit<DeleteMemberFromGroupState> {
  final DeleteUserFromGroupUsecase _deleteUserFromGroupUsecase;
  String? _errMessage;

  DeleteMemberFromGroupCubit(this._deleteUserFromGroupUsecase)
    : super(DeleteMemberInitial());

  void deleteMember(String userId) async {
    emit(DeleteMemberLoading());
    var result = await _deleteUserFromGroupUsecase.execute(userId);
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(DeleteMemberError(_errMessage!));
      },
      (isSuccess) {
        emit(DeleteMemberSuccess());
      },
    );
  }
}
