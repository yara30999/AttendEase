import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecase/current_user_join_group_usecase.dart';

part 'current_user_join_group_state.dart';

class CurrentUserJoinGroupCubit extends Cubit<CurrentUserJoinGroupState> {
  final CurrentUserJoinGroupUsecase _currentUserJoinGroupUsecase;

  CurrentUserJoinGroupCubit(this._currentUserJoinGroupUsecase)
      : super(CurrentUserJoinGroupInitial());

  void joinGroup(String groupId) async {
    emit(CurrentUserJoinGroupLoading());
    final result = await _currentUserJoinGroupUsecase.execute(groupId);
    result.fold(
          (failure) {
        emit(CurrentUserJoinGroupError(failure.message));
      },
          (success) {
        emit(CurrentUserJoinGroupSuccess());
      },
    );
  }
}