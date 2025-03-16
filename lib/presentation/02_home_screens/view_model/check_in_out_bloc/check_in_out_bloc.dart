import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../../app/extensions.dart';
import '../../../../app/functions.dart';
import '../../../../app/geolocation_service.dart';
import '../../../../domain/entities/group_entity.dart';
import '../../../../domain/usecase/can_user_have_action_today_usecase.dart';
import '../../../../domain/usecase/check_in_current_user_usecase.dart';
import '../../../../domain/usecase/check_out_current_user_usecase.dart';

part 'check_in_out_event.dart';
part 'check_in_out_state.dart';

class CheckInOutBloc extends HydratedBloc<CheckInOutEvent, CheckInOutState> {
  final CheckInCurrentUser _checkInCurrentUser;
  final CheckOutCurrentUser _checkOutCurrentUser;
  final CanUserHaveActionTodayUsecase _canUserHaveActionTodayUsecase;
  final IGeolocationService _geolocationService;
  LatLng? _currentUserLocation;
  LatLng? _groupLocation;
  // _historyDocId need to be saved in hydrated bloc
  String? _historyDocId;
  // _currentCheckInStatus need to be saved in hydrated bloc
  CheckStatus _currentCheckInStatus = CheckStatus.checkIn;
  // _currentCheckInTime need to be saved in hydrated bloc
  DateTime? _currentCheckInTime = null;
  String? _errMessage;
  bool get isTryingToCheckIn => _currentCheckInStatus == CheckStatus.checkIn;

  CheckInOutBloc(
    this._checkInCurrentUser,
    this._checkOutCurrentUser,
    this._canUserHaveActionTodayUsecase,
    this._geolocationService,
  ) : super(CheckInOutInitial(CheckStatus.checkIn, null)) {
    on<CheckInRequested>(onCheckInRequested);
    on<CheckOutRequested>(onCheckOutRequested);
  }

  FutureOr<void> onCheckInRequested(
    CheckInRequested event,
    Emitter<CheckInOutState> emit,
  ) async {
    emit(CheckInOutLoading(_currentCheckInStatus, _currentCheckInTime));
    if (!_isWithinCheckInTime(event.groupEntity)) {
      _emitError(emit, tr('outside_the_working_hours'));
      return;
    }
    if (!await _getUserAndGroupLocation(event.groupEntity, emit)) {
      return;
    }
    if (!_isUserInsideWorkRegion()) {
      _emitError(emit, tr('outside_the_working_location'));
      return;
    }
    if (!await _validateUserCheckInAndPermissions(event.groupEntity.id, emit)) {
      return;
    }
    await _performUserCheckIn(event.groupEntity.id, emit);
  }

  bool _isWithinCheckInTime(GroupEntity groupEntity) {
    return isWithinCheckInTime(groupEntity);
  }

  Future<bool> _getUserAndGroupLocation(
    GroupEntity groupEntity,
    Emitter<CheckInOutState> emit,
  ) async {
    try {
      _currentUserLocation = await _geolocationService.getCurrentUserLocation();
      _groupLocation = LatLng(
        groupEntity.location.latitude,
        groupEntity.location.longitude,
      );
      return true;
    } catch (error) {
      _emitError(emit, error.toString());
      return false;
    }
  }

  bool _isUserInsideWorkRegion() {
    return _geolocationService.isUserLocationNearToWorkLocation(
      _currentUserLocation!,
      _groupLocation!,
    );
  }

  Future<bool> _validateUserCheckInAndPermissions(
    String groupId,
    Emitter<CheckInOutState> emit,
  ) async {
    var result = await _canUserHaveActionTodayUsecase.execute(groupId);
    return result.fold((failure) {
      _emitError(emit, '${failure.message} ${failure.code}');
      return false;
    }, (canUserCheckInForToday) => true);
  }

  Future<void> _performUserCheckIn(
    String groupId,
    Emitter<CheckInOutState> emit,
  ) async {
    _historyDocId = generateRandomFirebaseDocId();
    _currentCheckInTime = DateTime.now();

    var result = await _checkInCurrentUser.execute(
      CheckInUsecaseInput(_historyDocId!, groupId, _currentCheckInTime!),
    );

    result.fold((failure) => _emitError(emit, failure.message), (isSuccess) {
      _currentCheckInStatus = CheckStatus.checkOut;
      emit(CheckInOutSuccess(_currentCheckInStatus, _currentCheckInTime));
    });
  }

  void _emitError(Emitter<CheckInOutState> emit, String message) {
    _errMessage = message;
    emit(CheckInOutError(_currentCheckInStatus, _currentCheckInTime, message));
  }

  FutureOr<void> onCheckOutRequested(
    CheckOutRequested event,
    Emitter<CheckInOutState> emit,
  ) async {
    emit(CheckInOutLoading(_currentCheckInStatus, _currentCheckInTime));
    var result = await _checkOutCurrentUser.execute(
      CheckOutUsecaseInput(
        _historyDocId!,
        event.groupEntity.id,
        DateTime.now(),
      ),
    );
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(
          CheckInOutError(
            _currentCheckInStatus,
            _currentCheckInTime,
            _errMessage!,
          ),
        );
      },
      (isSuccess) {
        // switch _currentCheckInStatus to checkIn for next button click.
        _currentCheckInStatus = CheckStatus.checkIn;
        // then clear the _historyDocId & _currentCheckInTime ;)
        _historyDocId = null;
        _currentCheckInTime = null;
        emit(CheckInOutSuccess(_currentCheckInStatus, _currentCheckInTime));
      },
    );
  }

  @override
  CheckInOutState? fromJson(Map<String, dynamic> json) {
    try {
      _historyDocId = json['historyDocId'] as String?;
      _currentCheckInStatus =
          CheckStatus.values[json['currentCheckInStatus'] as int];
      _currentCheckInTime =
          json['currentCheckInTime'] != null
              ? DateTime.parse(json['currentCheckInTime'] as String)
              : null;
      return CheckInOutSuccess(_currentCheckInStatus, _currentCheckInTime);
    } catch (e) {
      return CheckInOutInitial(_currentCheckInStatus, _currentCheckInTime);
    }
  }

  @override
  Map<String, dynamic>? toJson(CheckInOutState state) {
    return {
      'historyDocId': _historyDocId,
      'currentCheckInStatus':
          _currentCheckInStatus.index, // Convert enum to int
      'currentCheckInTime':
          _currentCheckInTime?.toIso8601String(), // Store DateTime as String
    };
  }
}
