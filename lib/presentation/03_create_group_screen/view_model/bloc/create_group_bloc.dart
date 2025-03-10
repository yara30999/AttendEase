import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../app/extensions.dart';
import '../../../../app/geolocation_service.dart';
import '../../../../domain/usecase/create_group_usecase.dart';
part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  final CreateGroupUsecase _createGroupUsecase;
  final IGeolocationService _geolocationService;

  String? _errMessage;
  LatLng? selectedLocation;
  LatLng? currentUserLocation;

  CreateGroupBloc(this._createGroupUsecase, this._geolocationService)
    : super(CreateGroupInitial()) {
    on<CreateGroupRequested>(onCreateGroupRequested);
    on<CurrentUserLocationRequested>(onCurrentUserLocationRequested);
    on<LocationPicked>(onLocationPicked);
  }

  FutureOr<void> onCreateGroupRequested(
    CreateGroupRequested event,
    Emitter<CreateGroupState> emit,
  ) async {
    emit(CreateGroupLoading());
    if (event.days.isEmpty) {
      _errMessage = tr("Please_select_days");
      emit(CreateGroupError(_errMessage!));
      return; //break the function here.
    }
    if (selectedLocation == null) {
      _errMessage = tr("Please_select_location");
      emit(CreateGroupError(_errMessage!));
      return; //break the function here.
    }
    var result = await _createGroupUsecase.execute(
      CreateGroupUseCaseInput(
        event.groupName,
        event.checkInTime.toDateTime(),
        event.checkOutTime.toDateTime(),
        event.days,
        GeoPoint(selectedLocation!.latitude, selectedLocation!.longitude),
      ),
    );
    result.fold(
      (failure) {
        _errMessage =
            '${failure.message.toString()} ${failure.code.toString()}';
        emit(CreateGroupError(_errMessage!));
      },
      (isSuccess) {
        emit(CreateGroupSuccess());
      },
    );
  }

  FutureOr<void> onCurrentUserLocationRequested(
    CurrentUserLocationRequested event,
    Emitter<CreateGroupState> emit,
  ) async {
    emit(CurrentUserLocationLoading());
    try {
      currentUserLocation = await _geolocationService.getCurrentUserLocation();
      emit(CurrentUserLocationSuccess());
    } catch (error) {
      emit(CurrentUserLocationError(error.toString()));
    }
  }

  FutureOr<void> onLocationPicked(
    LocationPicked event,
    Emitter<CreateGroupState> emit,
  ) {
    selectedLocation = event.location;
    emit(LocationPickedSuccess(event.location));
  }
}
