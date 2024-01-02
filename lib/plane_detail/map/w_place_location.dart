import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maptravel/dto/vo_place.dart';

class PlaceLocationWidget extends StatelessWidget {
  final Place place;
  final GoogleMapController? mapController;

  const PlaceLocationWidget(
      {super.key, required this.place, this.mapController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(place.latitude, place.longitude),
              zoom: 17,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(place.pictureUrlArray[0]),
          ),
        ),
      ),
    );
  }
}
