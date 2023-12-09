import 'package:flutter/material.dart';
import 'package:maptravel/Home/w_search_widget.dart';
import 'package:maptravel/alert_dialog/alert_dialog.dart';
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
  final ScrollController _scrollController = ScrollController();

  void waitAPI() async {
    _planeListResponse = await getPlaneList(0);
    _planeList = _planeListResponse.content;

    setState(() {});
  }

  void addPlane() async {

    if (!_planeListResponse.last) {
      final PlaneListResponse response = await getPlaneList(
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
      printEnd(); // 맨 아래에 도달했을 때 실행할 메서드
      addPlane();
    }
  }

  void printEnd() {
    print('끝에 도달');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchWidget(),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              // children: _planeList
              //     .map((planeList) => PlaneWidget(planeList: planeList))
              //     .toList()),
              children: List.generate(_planeList.length,
                      (index) => PlaneWidget(planeList: _planeList[index])),
            ),
          ),
        )
      ],
    );
  }
}
