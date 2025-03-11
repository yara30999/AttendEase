part of 'create_group_bloc.dart';

sealed class CreateGroupState extends Equatable {
  const CreateGroupState();

  @override
  List<Object> get props => [];
}

final class CreateGroupInitial extends CreateGroupState {}

//................................................ Create Group states
final class CreateGroupLoading extends CreateGroupState {}

final class CreateGroupSuccess extends CreateGroupState {}

final class CreateGroupError extends CreateGroupState {
  final String errMessage;

  const CreateGroupError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}

//................................................ Current User Location states
final class CurrentUserLocationLoading extends CreateGroupState {}

final class CurrentUserLocationSuccess extends CreateGroupState {}

final class CurrentUserLocationError extends CreateGroupState {
  final String errMessage;

  const CurrentUserLocationError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}

//................................................ Location Picked states
final class LocationPickedSuccess extends CreateGroupState {
  final LatLng location;

  LocationPickedSuccess(this.location);

  @override
  List<Object> get props => [super.props, location];
}
