import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/permission_entity.dart';
import '../../../../domain/usecase/get_user_permissions_usecase.dart';
part 'user_permissions_event.dart';
part 'user_permissions_state.dart';

class UserPermissionsBloc
    extends Bloc<UserPermissionsEvent, UserPermissionsState> {
  final GetUserPermissionsUsecase _userPermissionsUsecase;
  String? _errorMessage;
  UserPermissionsBloc(this._userPermissionsUsecase)
    : super(UserPermissionsInitial()) {
    on<UserPermissionsEventRequested>(onUserPermissionsRequested);
  }

  FutureOr<void> onUserPermissionsRequested(
    UserPermissionsEventRequested event,
    Emitter<UserPermissionsState> emit,
  ) async {
    emit(UserPermissionsLoading());
    var result = await _userPermissionsUsecase.execute(event.userId);
    result.fold(
      (failure) {
        _errorMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(UserPermissionsError(_errorMessage!));
      },
      (userPermissionsList) {
        emit(UserPermissionsSuccess(userPermissionsList));
      },
    );
  }
}
