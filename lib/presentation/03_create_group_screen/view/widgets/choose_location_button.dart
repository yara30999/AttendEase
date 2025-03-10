import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../app/functions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/routes_manager.dart';
import '../../view_model/bloc/create_group_bloc.dart';

class ChooseLocationButton extends StatefulWidget {
  const ChooseLocationButton({super.key});

  @override
  State<ChooseLocationButton> createState() => _ChooseLocationButtonState();
}

class _ChooseLocationButtonState extends State<ChooseLocationButton> {
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onLocationPicked(LatLng location) async {
    _markers.add(
      Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position: location,
        infoWindow: InfoWindow(
          title: 'picked_place'.tr(),
          snippet: 'you_picked_this_location'.tr(),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    setState(() {}); // for marker to appear on the map :)
    // Move camera to new position
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(location, 12.0));
      debugPrint('Camera moved to: $location');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<CreateGroupBloc>().add(CurrentUserLocationRequested());
      },
      child: BlocListener<CreateGroupBloc, CreateGroupState>(
        listener: (context, state) {
          if (state is CurrentUserLocationSuccess) {
            Navigator.pushNamed(
              context,
              Routes.pickLocationRoute,
              // Pass the existing Bloc
              arguments: context.read<CreateGroupBloc>(),
            );
          }
          if (state is CurrentUserLocationError) {
            showToast(state.errMessage, ColorsManager.softRed);
          }
          if (state is LocationPickedSuccess) {
            _onLocationPicked(state.location);
          }
        },
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: IgnorePointer(
              child: GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(30.033333, 31.233334), // Cairo
                  zoom: 12,
                ),
                markers: _markers,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
