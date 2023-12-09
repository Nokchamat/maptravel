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
          http.Response bookmarkResponse =
              await http.get(Uri.parse('$baseUrl/v1/plane/bookmark'), headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "access_token": accessToken,
          });
          _bookmarkResponse = BookmarkResponse.fromJson(
              json.decode(utf8.decode(bookmarkResponse.bodyBytes)));

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
