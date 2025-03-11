import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapCard extends StatelessWidget {
  final GeoPoint geoPoint;
  const LocationMapCard(this.geoPoint, {Key? key}) : super(key: key);

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
              target: LatLng(geoPoint.latitude, geoPoint.latitude),
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              Marker(
                markerId: MarkerId('workLocation'),
                position: LatLng(geoPoint.latitude, geoPoint.latitude),
                infoWindow: InfoWindow(title: 'Work Location'),
              ),
            },
          ),
        ),
      ),
    );
  }
}
