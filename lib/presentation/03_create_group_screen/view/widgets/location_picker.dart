import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../view_model/bloc/create_group_bloc.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  static const LatLng _defaultLocation = LatLng(30.033333, 31.233334); // Cairo
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: _defaultLocation,
            zoom: 12,
          ),
          onTap: (LatLng location) {
            //update the map state. :)
            setState(() {
              _selectedLocation = location;
            });
            //then pass the location to the bloc.
            context.read<CreateGroupBloc>().selectedLocation =
                _selectedLocation;
          },
          markers:
              _selectedLocation == null
                  ? {}
                  : {
                    Marker(
                      markerId: const MarkerId('selected_location'),
                      position: _selectedLocation!,
                    ),
                  },
        ),
      ),
    );
  }
}
