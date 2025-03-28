import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/extensions.dart';
import '../../../../domain/usecase/can_user_have_action_today_usecase.dart';
import '../../../../domain/usecase/current_user_take_permission_usecase.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final CurrentUserTakePermissionUsecase _permissionUsecase;
  final CanUserHaveActionTodayUsecase _canUserHaveActionTodayUsecase;
  String? _errMessage;
  PermissionType initPermission = PermissionType.emergencyLeave;

  PermissionCubit(this._permissionUsecase, this._canUserHaveActionTodayUsecase)
    : super(PermissionInitial());

  void takePermission({
    required String groupId,
    required DateTime time,
    String? message,
  }) async {
    emit(PermissionLoading());
    if (!await _validateUserCheckInAndPermissions(groupId)) {
      return;
    }
    await _performUserPermission(groupId, time, message);
  }

  Future<bool> _validateUserCheckInAndPermissions(String groupId) async {
    var result = await _canUserHaveActionTodayUsecase.execute(groupId);
    return result.fold((failure) {
      _emitError('${failure.message} ${failure.code}');
      return false;
    }, (canUserCheckInForToday) => true);
  }

  Future<void> _performUserPermission(
    String groupId,
    DateTime time,
    String? message,
  ) async {
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

  void _emitError(String message) {
    _errMessage = message;
    emit(PermissionError(_errMessage!));
  }
}
