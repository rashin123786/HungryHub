// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hungryhub/controller/constants/constants.dart';

import 'package:provider/provider.dart';

import '../../../controller/provider/add_address.dart';

const LatLng currentLocaction = LatLng(10.1632, 76.6413);
String placename = 'select your location on map';
bool isPress = false;
LatLng? locationsss;

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddAddressController>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: currentLocaction,
                zoom: 10,
              ),
              onTap: addressProvider.onMapTap,
              onMapCreated: addressProvider.onmapcreate,
              markers: addressProvider.markers,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    placename,
                    style: menuscreen20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          await addressProvider.addLocationToFirebase();

          Navigator.pop(context);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          "Set up location",
        ),
      ),
    );
  }
}
