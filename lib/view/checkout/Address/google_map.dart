import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

const LatLng currentLocaction = LatLng(10.1632, 76.6413);

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final controller = TextEditingController(text: 'kerala');

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocaction,
                zoom: 10,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: controller,
                      onTap: () {
                        placemarkerAddress();
                      },
                      decoration: InputDecoration(
                        hintText: 'search Location',
                        fillColor: Colors.white,
                        suffix: Icon(Icons.search),
                        prefixIcon: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  placemarkerAddress() async {
    List<Location> locations = await locationFromAddress(controller.text);
    final location = locations.first;
    final coordinates = LatLng(location.latitude, location.longitude);
    print(coordinates);
  }
}
