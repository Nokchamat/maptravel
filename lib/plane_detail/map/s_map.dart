import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maptravel/api/api_key.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  TextEditingController searchController = TextEditingController();
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Search'),
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Enter a location',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  searchLocation();
                },
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(33.557366, 130.465370),
                zoom: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchLocation() async {
    if (searchController.text.isNotEmpty) {
      print('searchLocation!! : ${searchController.text}');
      String key = googlePlaceApiKey;

        try {
          var response = await http.post(
            Uri.parse('https://places.googleapis.com/v1/places:searchText'),
            headers: {
              'Content-Type': 'application/json',
              'X-Goog-Api-Key': key,
              'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.priceLevel',
              'Accept-Language': 'ko', // 한국어로 결과를 요청
            },
            body: json.encode({
              'textQuery': searchController.text,
            }),
          );

          if (response.statusCode == 200) {
            // 요청 성공
            var jsonResponse = json.decode(response.body);
            print('Response: ${jsonResponse['places']}');
            List places = jsonResponse['places'];
            print('개수 : ${places.length}');
            for(int i=0; i<places.length; i++) {
              var item = places[i];
              var displayName = item['displayName'];
              print('$i번째 : ${item['formattedAddress']}, displayName : ${displayName['text']}');
            }

            // 여기에서 jsonResponse를 처리합니다.
          } else {
            // 요청 실패
            print('Request failed with status: ${response.statusCode}');
            print('Request failed with status: ${response.body}');
          }
        } catch (e) {
          // 에러 처리
          print('Error: $e');
        }
      //   mapController!.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //       target: LatLng(locations.first.latitude, locations.first.longitude),
      //       zoom: 14.0,
      //     ),
      //   ));
      //   _addMarker(LatLng(locations.first.latitude, locations.first.longitude));
    }
  }

  void _addMarker(LatLng position) {
    setState(() {
      markers = {
        Marker(
          markerId: MarkerId('searched_location'),
          position: position,
          infoWindow: InfoWindow(title: 'Searched Location'),
        ),
      };
    });
  }
}
