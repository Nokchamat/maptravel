import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/bookmark/w_bookmark.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/dto/vo_bookmark.dart';
import 'package:maptravel/sign/f_login.dart';

import '../api/common.dart';

class BookmarkFragment extends StatefulWidget {
  const BookmarkFragment({super.key});

  @override
  State<BookmarkFragment> createState() => _BookmarkFragment();
}

class _BookmarkFragment extends State<BookmarkFragment> {
  List<Bookmark> _bookmarkList = [];
  late BookmarkResponse _bookmarkResponse;

  void waitAPI() async {
    getIsLogin().then(
      (value) => {
        if (value == null)
          {
            print('logout'),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginFragment()))
          },
      },
    );

    print('로그인 상태임');

    String? accessToken;
    accessToken = await getAccessToken();
    print(accessToken);
    http.Response bookmarkResponse;

    try {
      bookmarkResponse =
          await http.get(Uri.parse('$baseUrl/v1/plane/bookmark'), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });

      _bookmarkResponse = BookmarkResponse.fromJson(
          json.decode(utf8.decode(bookmarkResponse.bodyBytes)));

      print('============BookmarkResponse=======================');
      _bookmarkList = _bookmarkResponse.content;
      print(_bookmarkList[0].country);
      print(_bookmarkList[0].city);
      print(_bookmarkList[0].userNickname);
      print('============BookmarkResponse=======================');
    } catch (error) {
      String? refreshToken;
      refreshToken = await getRefreshToken();

      if (refreshToken == null) {
        print('refresh null');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginFragment()));
      }

      final refreshResponse =
          await http.get(Uri.parse('$baseUrl/v1/token/refresh'), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "refresh_token": refreshToken!,
      });

      print('===========BookmarkRefreshResponse================');
      print(refreshResponse.statusCode);
      print(refreshResponse.headers);
      print('=============access_token==============');
      print(refreshResponse.headers['access_token']);
      print('=============refresh_token==============');
      print(refreshResponse.headers['refresh_token']);
      print('=============BookmarkRefreshResponse==============');

      if (refreshResponse.statusCode != 200) {
        logout();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginFragment()));
      } else {
        print('===========refreshSavedResponse================');

        storage.read(key: 'refreshToken').then((value) => print(value));
        storage.read(key: 'accessToken').then((value) => print(value));
        savedRefreshToken(refreshResponse.headers['access_token']!,
            refreshResponse.headers['refresh_token']!);
        print('저장 후 토큰 바뀌었는지 확인');
        storage.read(key: 'refreshToken').then((value) => print(value));
        storage.read(key: 'accessToken').then((value) => print(value));
        print('===========refreshSavedResponse================');

        final newBookmarkResponse =
            await http.get(Uri.parse('$baseUrl/v1/plane/bookmark'), headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "access_token": accessToken ?? "",
        });

        _bookmarkResponse = BookmarkResponse.fromJson(
            json.decode(utf8.decode(newBookmarkResponse.bodyBytes)));
        print('============newBookmarkResponse=======================');
        _bookmarkList = _bookmarkResponse.content;
        print(_bookmarkList[0].country);
        print(_bookmarkList[0].city);
        print(_bookmarkList[0].userNickname);
        print('============newBookmarkResponse=======================');
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitAPI();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [
        ..._bookmarkList.map((bookmark) => BookmarkWidget(bookmark: bookmark))
      ],
    );
  }
}
