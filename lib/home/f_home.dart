import 'package:flutter/material.dart';
import 'package:maptravel/Home/w_search_widget.dart';
import 'package:maptravel/api/api_home.dart';
import 'package:maptravel/dto/vo_plane_list.dart';
import 'package:maptravel/home/w_plane.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  List<PlaneList> _planeList = [];
  late PlaneListResponse _planeListResponse;

  void waitAPI() async {
    _planeListResponse = await getPlaneList();
    _planeList = _planeListResponse.content;
    setState(() {});
  }

  @override
  void initState() {
    waitAPI();
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
                children: _planeList
                    .map((planeList) => PlaneWidget(planeList: planeList))
                    .toList()),
          ),
        ),
      ],
    );
  }
}
