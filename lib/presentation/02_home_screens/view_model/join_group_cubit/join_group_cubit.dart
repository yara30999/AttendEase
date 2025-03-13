import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecase/current_user_join_group_usecase.dart';

part 'join_group_state.dart';

class JoinGroupCubit extends Cubit<JoinGroupState> {
  final CurrentUserJoinGroupUsecase _currentUserJoinGroupUsecase;
  String? _errMessage;

  JoinGroupCubit(this._currentUserJoinGroupUsecase) : super(JoinGroupInitial());

  void joinGroup(String groupId) async {
    emit(JoinGroupLoading());
    var result = await _currentUserJoinGroupUsecase.execute(groupId);
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(JoinGroupError(_errMessage!));
      },
      (isSuccess) {
        emit(JoinGroupSuccess());
      },
    );
  }
}
