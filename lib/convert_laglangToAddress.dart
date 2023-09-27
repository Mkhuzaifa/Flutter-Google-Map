import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLagLangToAddress extends StatefulWidget {
  const ConvertLagLangToAddress({super.key});

  @override
  State<ConvertLagLangToAddress> createState() => _ConvertLagLangToAddressState();
}

class _ConvertLagLangToAddressState extends State<ConvertLagLangToAddress> {
  String _address = '';
  String _placeAdrress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(_address.toString()),
            // Text(_placeAdrress.toString()),
          SizedBox(height: 10,),
          Center(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: ()async {

                List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");

                List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);




                
                print("");
                setState(() {
                  _address = locations.last.latitude.toString();
                  _placeAdrress = placemarks.reversed.last.country.toString() +" "+ placemarks.reversed.last.locality.toString();
                });

              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: Center(child: Text("Convert",style: TextStyle(color: Colors.white),),),
              ),
            ),
          )
        ],),
      ),
    );
  }
}
