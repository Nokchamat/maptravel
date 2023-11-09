import 'package:flutter/material.dart';
import 'package:maptravel/Home/w_search_widget.dart';
import 'package:maptravel/home/vo/dummy.dart';
import 'package:maptravel/home/vo/vo_plane.dart';
import 'package:maptravel/home/w_plane.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Plane> _planeList;

  @override
  void initState() {
    _planeList = planeList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchWidget(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: _planeList.map((plane) => PlaneWidget(plane: plane)).toList()
            ),
          ),
        ),
      ],
    );
  }
}
