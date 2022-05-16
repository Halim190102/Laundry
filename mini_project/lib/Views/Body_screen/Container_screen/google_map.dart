import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng _curretPossition = const LatLng(5.217274, 97.054658);
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) async {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  @override
  void initState() {
    _markers.add(
      Marker(
        markerId: const MarkerId("5.217274, 97.054658"),
        position: _curretPossition,
        infoWindow: const InfoWindow(
          title: 'Loundry',
        ),
      ),
    );
    super.initState();
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() async {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 20,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 260,
            child: GoogleMap(
              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                target: _curretPossition,
                zoom: 17,
              ),
              onMapCreated: _onMapCreated,
              markers: _markers,
            ),
          ),
          Positioned(
            top: 5,
            child: ElevatedButton(
              onPressed: _onMapTypeButtonPressed,
              child: const Icon(Icons.map),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                primary: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
