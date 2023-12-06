import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/dto/vo_plane.dart';
import 'package:maptravel/plane_detail/w_detail_place.dart';
import 'package:maptravel/plane_detail/w_plane_detail_app_bar.dart';

import '../api/common.dart';
import '../dto/vo_place.dart';

class PlaneDetailScreen extends StatefulWidget {
  final int planeId;

  const PlaneDetailScreen({super.key, required this.planeId});

  @override
  State<PlaneDetailScreen> createState() => _PlaneDetailScreenState();
}

class _PlaneDetailScreenState extends State<PlaneDetailScreen> {
  late Future<void> _apiFuture;
  late Plane plane;
  late List<Place> placeList = [];

  @override
  void initState() {
    super.initState();
    _apiFuture = waitAPI();
  }

  Future<void> waitAPI() async {
    String? accessToken = await getAccessToken();

    try {
      final jsonResponse = await http.get(
        Uri.parse('$baseUrl/v1/plane/${widget.planeId}'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "access_token": accessToken ?? "",
        },
      );

      plane = Plane.fromJson(json.decode(utf8.decode(jsonResponse.bodyBytes)));
      placeList = plane.placeList;
    } catch (err) {
      print(err);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _apiFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return buildContent();
        }
      },
    );
  }

  Widget buildContent() {
    return Scaffold(
      appBar: PlaneDetailAppBarWidget(
        plane: plane,
        context: context,
        appBar: AppBar(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // DetailPlaneWidget(plane: plane),
              // Container(
              //   color: Colors.grey.shade200,
              //   height: 8,
              // ),
              // Center(
              //   child: SizedBox(
              //     height: 50,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text('장소',
              //           style: Theme.of(context).textTheme.headlineLarge),
              //     ),
              //   ),
              // ),
              Column(
                children: List.generate(
                  placeList.length,
                  (index) => DetailPlaceWidget(place: placeList[index]),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
