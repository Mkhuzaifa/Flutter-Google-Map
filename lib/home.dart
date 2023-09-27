import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(markerId: MarkerId("1"),position: LatLng(33.6844, 73.0479),
    infoWindow: InfoWindow(title: "MY current Location"))
  ];

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _keyGooglePlex = CameraPosition(target:
  LatLng(33.6844, 73.0479),zoom: 14);

  @override
  void initState() {
   _marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled),
        onPressed: ()async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(35.6762,139.6503),zoom: 14),
          ),);
            setState(() {

            });
        },
      ),
      body: SafeArea(
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: Set<Marker>.of(_marker),
          initialCameraPosition: _keyGooglePlex,
        ),
      )
    );
  }
}
