import 'package:flutter/material.dart';
import 'package:maptravel/profile/w_plane_list.dart';

import '../alert_dialog/alert_dialog.dart';
import '../api/api_home.dart';
import '../dto/vo_plane_list.dart';

class MyPlane extends StatefulWidget {
  final int userId;

  const MyPlane({super.key, required this.userId});

  @override
  State<MyPlane> createState() => _MyPlaneState();
}

class _MyPlaneState extends State<MyPlane> {
  List<PlaneList> _planeList = [];
  late PlaneListResponse _planeListResponse;
  final ScrollController _scrollController = ScrollController();

  void waitAPI() async {
    _planeListResponse = await getMyPlaneList(0);
    _planeList = _planeListResponse.content;

    setState(() {});
  }

  void addPlane() async {
    if (!_planeListResponse.last) {
      final PlaneListResponse response = await getMyPlaneList(
          (_planeListResponse.number + 1));
      setState(() {
        _planeListResponse = response;
        _planeList += response.content;
      });
    } else {
      showAlertDialog(context, '여행 계획의 마지막...');
    }
  }

  @override
  void initState() {
    waitAPI();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    // 스크롤 위치가 최하단인지 확인
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      addPlane();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내가 작성한 여행'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(2),
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        controller: _scrollController,
        children: _planeList.map((plane) {
          return GridPlaneWidget(
            plane: plane,
            onRemove: () {
              setState(() {
                _planeList.remove(plane); // 해당 위젯 제거
              });
            },
          );
        }).toList(),
      )
    );
  }
}
