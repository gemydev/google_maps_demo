import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  double latitude;
  double longitude;

  MapSample({@required this.latitude, @required this.longitude});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [
      Marker(
          position: LatLng(widget.latitude, widget.longitude),
          markerId: MarkerId("CurrentLocation"),
          infoWindow: InfoWindow(
            title: "Your Location",
          )),
    ];
    CameraPosition _cameraPosition = CameraPosition(
      // bearing: 192.8334901395799,
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 15.4746,
      // tilt: 59.440717697143555,
    );

    return new Scaffold(
      body: GoogleMap(
        markers: markers.toSet(),
        mapType: MapType.hybrid,
        initialCameraPosition: _cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
