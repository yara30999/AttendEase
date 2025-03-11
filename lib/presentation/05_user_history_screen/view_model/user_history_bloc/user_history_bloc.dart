import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/history_entity.dart';
import '../../../../domain/usecase/get_user_history_usecase.dart';
part 'user_history_event.dart';
part 'user_history_state.dart';

class UserHistoryBloc extends Bloc<UserHistoryEvent, UserHistoryState> {
  final GetUserHistoryUsecase _userHistoryUsecase;

  String? _errMessage;
  List<HistoryEntity>? userHistory;

  UserHistoryBloc(this._userHistoryUsecase) : super(UserHistoryInitial()) {
    on<UserHistoryRequested>(onUserHistoryRequested);
  }

  FutureOr<void> onUserHistoryRequested(
    UserHistoryRequested event,
    Emitter<UserHistoryState> emit,
  ) async {
    emit(UserHistoryLoading());
    var result = await _userHistoryUsecase.execute(
      event.userId,
    );
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(UserHistoryError(_errMessage!));
      },
      (userHistory) {
        emit(UserHistorySuccess(userHistory));
      },
    );
  }
}
