import 'package:flutter/material.dart';
import 'package:maptravel/alert_dialog/alert_dialog.dart';
import 'package:maptravel/api/api_home.dart';
import 'package:maptravel/common/enum/search_type.dart';
import 'package:maptravel/dto/vo_plane_list.dart';
import 'package:maptravel/home/w_plane.dart';

class SearchPlaneScreen extends StatefulWidget {
  final String searchText;
  final SearchType searchType;

  const SearchPlaneScreen(
      {super.key, required this.searchText, required this.searchType});

  @override
  State<SearchPlaneScreen> createState() => _SearchPlaneScreen();
}

class _SearchPlaneScreen extends State<SearchPlaneScreen> {
  List<PlaneList> _planeList = [];
  late PlaneListResponse _planeListResponse;
  final ScrollController _scrollController = ScrollController();

  void waitAPI() async {
    if (widget.searchType == SearchType.nickname) {
      _planeListResponse = await getPlaneListByNickname(widget.searchText, 0);
    } else {
      _planeListResponse = await getPlaneListByLocation(widget.searchText, 0);
    }

    _planeList = _planeListResponse.content;

    setState(() {});
  }

  void addPlane() async {
    if (!_planeListResponse.last) {
      if (widget.searchType == SearchType.nickname) {
        final PlaneListResponse response = await getPlaneListByNickname(
            widget.searchText, (_planeListResponse.number + 1));
        setState(() {
          _planeListResponse = response;
          _planeList += response.content;
        });
      } else {
        final PlaneListResponse response = await getPlaneListByLocation(
            widget.searchText, (_planeListResponse.number + 1));
        setState(() {
          _planeListResponse = response;
          _planeList += response.content;
        });
      }
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
        title: Text('"${widget.searchText}" 검색 결과'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: List.generate(_planeList.length,
              (index) => PlaneWidget(planeList: _planeList[index])),
        ),
      ),
    );
  }
}
