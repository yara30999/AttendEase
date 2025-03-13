import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/group_entity.dart';
import '../../../../domain/usecase/get_group_info_usecase.dart';
part 'group_details_event.dart';
part 'group_details_state.dart';

class GroupDetailsBloc extends Bloc<GroupDetailsEvent, GroupDetailsState> {
  final GetGroupInfoUsecase _groupInfoUsecase;

  String? _errMessage;

  GroupDetailsBloc(this._groupInfoUsecase) : super(GroupDetailsInitial()) {
    on<GroupDetailsRequested>(onGroupDetailsRequested);
  }

  FutureOr<void> onGroupDetailsRequested(
    GroupDetailsRequested event,
    Emitter<GroupDetailsState> emit,
  ) async {
    emit(GroupDetailsLoading());
    var result = await _groupInfoUsecase.execute(event.groupId);
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(GroupDetailsError(_errMessage!));
      },
      (groupInfo) {
        emit(GroupDetailsSuccess(groupInfo));
      },
    );
  }
}
