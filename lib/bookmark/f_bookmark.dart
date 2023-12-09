import 'package:flutter/material.dart';
import 'package:maptravel/api/api_bookmark.dart';
import 'package:maptravel/bookmark/w_bookmark.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/dto/vo_bookmark.dart';
import 'package:maptravel/sign/f_login.dart';

import '../alert_dialog/alert_dialog.dart';

class BookmarkFragment extends StatefulWidget {
  const BookmarkFragment({super.key});

  @override
  State<BookmarkFragment> createState() => _BookmarkFragment();
}

class _BookmarkFragment extends State<BookmarkFragment> {
  List<Bookmark> _bookmarkList = [];
  late BookmarkResponse _bookmarkResponse;
  final ScrollController _scrollController = ScrollController();

  void waitAPI() async {
    String? isLogin = await getIsLogin();

    if (isLogin == null) {
      print('로그아웃 상태임 isLogin : $isLogin');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginFragment()));
    } else {
      print('로그인 상태임');
      String? accessToken;
      accessToken = await getAccessToken();
      if (accessToken != null) {
        try {
          _bookmarkResponse = await getBookmark(0);
          _bookmarkList = _bookmarkResponse.content;
        } catch (error) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginFragment()));
        }
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginFragment()));
      }
    }

    setState(() {});
  }

  void removeBookmark(Bookmark bookmarkToRemove) {
    print('length : ${_bookmarkList.length}');
    setState(() {
      _bookmarkList.remove(bookmarkToRemove); // 해당 위젯 제거
    });
    print('length : ${_bookmarkList.length}');
  }

  void _scrollListener() {
    // 스크롤 위치가 최하단인지 확인
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('scrollBottom');
      addBookmark();
    }
  }

  void addBookmark() async {
    if (!_bookmarkResponse.last) {
      final BookmarkResponse response =
          await getBookmark((_bookmarkResponse.number + 1));
      setState(() {
        _bookmarkResponse = response;
        _bookmarkList += response.content;
      });
    } else {
      showAlertDialog(context, '북마크의 마지막...');
    }
  }

  @override
  void initState() {
    super.initState();
    waitAPI();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(2),
      crossAxisCount: 2,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      controller: _scrollController,
      children: _bookmarkList.map((bookmark) {
        return BookmarkWidget(
          bookmark: bookmark,
          onRemove: () {
            removeBookmark(bookmark);
          },
        );
      }).toList(),
    );
  }
}
