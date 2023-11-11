import 'package:flutter/material.dart';
import 'package:maptravel/Home/w_search_widget.dart';
import 'package:maptravel/vo/dummy.dart';
import 'package:maptravel/home/w_plane.dart';

import '../vo/vo_plane.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
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
        const SearchWidget(),
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
