import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecase/delete_group_usecase.dart';

part 'delete_group_state.dart';

class DeleteGroupCubit extends Cubit<DeleteGroupState> {
  final DeleteGroupUsecase _deleteGroupUsecase;
  String? _errMessage;

  DeleteGroupCubit(this._deleteGroupUsecase) : super(DeleteGroupInitial());

  void deleteGroup(String groupId) async {
    emit(DeleteGroupLoading());
    var result = await _deleteGroupUsecase.execute(groupId);
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(DeleteGroupError(_errMessage!));
      },
      (isSuccess) {
        emit(DeleteGroupSuccess());
      },
    );
  }
}
