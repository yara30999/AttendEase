import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapCard extends StatefulWidget {
  final GeoPoint geoPoint;
  const LocationMapCard(this.geoPoint, {Key? key}) : super(key: key);

  @override
  State<LocationMapCard> createState() => _LocationMapCardState();
}

class _LocationMapCardState extends State<LocationMapCard> {
  final Set<Marker> _markers = {};
  LatLng? _location;
  GoogleMapController? _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_location!, 12.0),
      );
      debugPrint('Camera moved to: $_location');
    }
  }

  @override
  void initState() {
    super.initState();
    _location = LatLng(widget.geoPoint.latitude, widget.geoPoint.longitude);
    _markers.add(
      Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position: _location!,
        infoWindow: InfoWindow(
          title: 'work_place'.tr(),
          snippet: 'this_is_your_work_location'.tr(),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

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
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _location!, zoom: 12),
            markers: _markers,
          ),
        ),
      ),
    );
  }
}
