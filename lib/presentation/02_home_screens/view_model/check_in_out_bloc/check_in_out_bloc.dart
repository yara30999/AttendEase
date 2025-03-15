import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../../app/extensions.dart';
import '../../../../app/functions.dart';
import '../../../../app/geolocation_service.dart';
import '../../../../domain/entities/group_entity.dart';
import '../../../../domain/usecase/check_in_current_user_usecase.dart';
import '../../../../domain/usecase/check_out_current_user_usecase.dart';

part 'check_in_out_event.dart';
part 'check_in_out_state.dart';

class CheckInOutBloc extends HydratedBloc<CheckInOutEvent, CheckInOutState> {
  final CheckInCurrentUser _checkInCurrentUser;
  final CheckOutCurrentUser _checkOutCurrentUser;
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
    bool isTimeAvailable = isWithinCheckInTime(event.groupEntity);
    if (!isTimeAvailable) {
      // if outside the working hours...
      _errMessage = tr('outside_the_working_hours');
      emit(
        CheckInOutError(
          _currentCheckInStatus,
          _currentCheckInTime,
          _errMessage!,
        ),
      );
      return null; //break the function here.
    } else {
      //get current user location first
      try {
        _currentUserLocation =
            await _geolocationService.getCurrentUserLocation();
        _groupLocation = LatLng(
          event.groupEntity.location.latitude,
          event.groupEntity.location.longitude,
        );
      } catch (error) {
        //this error from getCurrentUserLocation()
        emit(
          CheckInOutError(
            _currentCheckInStatus,
            _currentCheckInTime,
            error.toString(),
          ),
        );
        return null; //break the function here.
      }
      bool isInsideTheRegion = _geolocationService
          .isUserLocationNearToWorkLocation(
            _currentUserLocation!,
            _groupLocation!,
          );
      if (!isInsideTheRegion) {
        // if outside the working location...
        _errMessage = tr('outside_the_working_location');
        emit(
          CheckInOutError(
            _currentCheckInStatus,
            _currentCheckInTime,
            _errMessage!,
          ),
        );
        return null; //break the function here.
      } else {
        //trigged only when the time and locatin are valid.
        _historyDocId = generateRandomFirebaseDocId();
        _currentCheckInTime = DateTime.now();
        var result = await _checkInCurrentUser.execute(
          CheckInUsecaseInput(
            _historyDocId!,
            event.groupEntity.id,
            _currentCheckInTime!,
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
            // switch _currentCheckInStatus to checkOut for next button click.
            _currentCheckInStatus = CheckStatus.checkOut;
            emit(CheckInOutSuccess(_currentCheckInStatus, _currentCheckInTime));
          },
        );
      }
    }
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
