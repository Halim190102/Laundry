import 'dart:async';

import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:mini_project/Views/Body_screen/Add_data_screen/add_data.dart';
import 'package:mini_project/Views/Body_screen/Container_screen/container_1.dart';
import 'package:mini_project/Views/Body_screen/Container_screen/container_2.dart';

class Body1 extends StatefulWidget {
  const Body1({Key? key}) : super(key: key);

  @override
  State<Body1> createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng _curretPossition = const LatLng(5.217274, 97.054658);
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
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

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ayo Pesan Sekarang !!!'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddData(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(left: 35, top: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ContainerProduct(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 20,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 320,
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
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ContainerAbout(),
            )
          ],
        ),
      ),
    );
  }
}
