import 'package:flutter/material.dart';
import 'package:maptravel/home/w_user_plane_list.dart';

import '../alert_dialog/alert_dialog.dart';
import '../api/api_home.dart';
import '../dto/vo_plane_list.dart';

class PlaneListByUserScreen extends StatefulWidget {
  final int userId;
  final String userNickname;
  final String userProfileImageUrl;

  const PlaneListByUserScreen(
      {super.key,
      required this.userId,
      required this.userNickname,
      required this.userProfileImageUrl});

  @override
  State<PlaneListByUserScreen> createState() => _PlaneListByUserScreenState();
}

class _PlaneListByUserScreenState extends State<PlaneListByUserScreen> {
  List<PlaneList> _planeList = [];
  late PlaneListResponse _planeListResponse;
  final ScrollController _scrollController = ScrollController();

  void waitAPI() async {
    _planeListResponse = await getPlaneListByUserId(widget.userId, 0);
    _planeList = _planeListResponse.content;

    setState(() {});
  }

  void addPlane() async {
    if (!_planeListResponse.last) {
      final PlaneListResponse response = await getPlaneListByUserId(
          widget.userId, (_planeListResponse.number + 1));
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
          centerTitle: true,
          title: Center(
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: widget.userProfileImageUrl.isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 40,
                        )
                      : Image.network(
                          widget.userProfileImageUrl,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              title: Text(widget.userNickname),
              titleTextStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(2),
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          controller: _scrollController,
          children: _planeList.map((plane) {
            return GridPlaneByUserIdWidget(
              plane: plane,
              onRemove: () {
                setState(() {
                  _planeList.remove(plane); // 해당 위젯 제거
                });
              },
            );
          }).toList(),
        ));
  }
}
