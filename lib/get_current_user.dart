import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class getCurrentLoaction extends StatefulWidget {
  const getCurrentLoaction({super.key});

  @override
  State<getCurrentLoaction> createState() => _getCurrentLoactionState();
}

class _getCurrentLoactionState extends State<getCurrentLoaction> {

  List<Marker> _marker = [];

  List<Marker> _list = [
    Marker(markerId: MarkerId("1"),position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: "MY current Location"))];

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _keyGooglePlex = CameraPosition(target:
  LatLng(33.6844, 73.0479),zoom: 14);

  @override
  void initState() {
    _marker.addAll(_list);
    super.initState();
  }


  Future<Position> getCurrentLoaction()async{

    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print("error"+error.toString());
    });

    return await Geolocator.getCurrentPosition();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_disabled),
          onPressed: ()async {
            getCurrentLoaction().then((value) async {
              print(value.latitude.toString()+value.longitude.toString());
              
              _marker.add(
                Marker(markerId:
                MarkerId("1"),
                position: LatLng(value.latitude, value.longitude),infoWindow: InfoWindow(
                      title: "My current"
                    )),
              );

              CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude),zoom: 14);

              final GoogleMapController controller = await _controller .future;

              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {

              });
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
