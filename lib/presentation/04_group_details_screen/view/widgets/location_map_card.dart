import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../view_model/group_details_bloc/group_details_bloc.dart';

class LocationMapCard extends StatelessWidget {
  const LocationMapCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: getLocation(context),
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              Marker(
                markerId: MarkerId('workLocation'),
                position: getLocation(context),
                infoWindow: InfoWindow(title: 'Work Location'),
              ),
            },
          ),
        ),
      ),
    );
  }
}

LatLng getLocation(BuildContext context) {
    final _geoLocation = context.watch<GroupDetailsBloc>().groupInfo?.location ?? GeoPoint(0, 0);
    final _latLngLocation = LatLng(_geoLocation.latitude, _geoLocation.longitude);
    return _latLngLocation;
}