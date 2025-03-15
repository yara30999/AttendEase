import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/extensions.dart';
import '../../../../domain/usecase/current_user_take_permission_usecase.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final CurrentUserTakePermissionUsecase _permissionUsecase;
  String? _errMessage;
  PermissionType initPermission = PermissionType.emergencyLeave;

  PermissionCubit(this._permissionUsecase) : super(PermissionInitial());

  void takePermission({
    required String groupId,
    required DateTime time,
    String? message,
  }) async {
    emit(PermissionLoading());
    var result = await _permissionUsecase.execute(
      PermissionUsecaseInput(groupId, time, initPermission, message),
    );
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(PermissionError(_errMessage!));
      },
      (isSuccess) {
        emit(PermissionSuccess());
      },
    );
  }
}
