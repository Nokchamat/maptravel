import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maptravel/dto/vo_place.dart';
import 'package:maptravel/plane_detail/map/w_place_location.dart';

import '../../dto/vo_plane.dart';

class MapScreen extends StatefulWidget {
  final Plane plane;

  const MapScreen({super.key, required this.plane});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  TextEditingController searchController = TextEditingController();
  final List<Marker> _markers = [];
  bool showDetail = false;
  Place? currentPlace;

  init() async {
    List<Marker> markers = [];

    await Future.forEach(widget.plane.placeList, (place) {
      markers.add(
        Marker(
            markerId: MarkerId(place.subject),
            draggable: true,
            position: LatLng(place.latitude, place.longitude),
            infoWindow: InfoWindow(
              title: place.subject,
            ),
            onTap: () {
              setState(() {
                currentPlace = place;
                showDetail = true;
              });
            }),
      );
    });

    setState(() {
      _markers.addAll(markers);
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('지도로 보기'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            markers: Set.from(_markers),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.plane.placeList[0].latitude,
                widget.plane.placeList[0].longitude,
              ),
              zoom: 12.0,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.plane.placeList.map((place) {
                  return PlaceLocationWidget(
                    place: place,
                    mapController: mapController,
                  );
                }).toList(),
              ),
            ),
          ),
          if (showDetail == true)
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: TapRegion(
                  onTapOutside: (tap) {
                    if (showDetail) {
                      setState(() {
                        showDetail = false;
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(currentPlace!.pictureUrlArray[0]),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentPlace!.subject,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  currentPlace!.content,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
