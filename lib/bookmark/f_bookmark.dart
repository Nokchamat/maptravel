import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/dto/vo_bookmark.dart';
import 'package:maptravel/sign/f_login.dart';

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

    String? accessToken;
    accessToken = await getAccessToken();

    final bookmarkResponse = await http.get(
        Uri.parse(
            'http://ec2-13-209-203-81.ap-northeast-2.compute.amazonaws.com:8080/v1/plane/bookmark'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "access_token": accessToken ?? "",
        });

    if (bookmarkResponse.statusCode == 500) {
      String? refreshToken;
      refreshToken = await getRefreshToken();

      if (refreshToken == null) {
        print('refresh null');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginFragment()));
      }

      final refreshResponse = await http.get(
          Uri.parse(
              'http://ec2-13-209-203-81.ap-northeast-2.compute.amazonaws.com:8080/v1/token/refresh'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "refresh_token": refreshToken!,
          });

      print('===========refreshResponse================');
      print(refreshResponse.statusCode);
      print(refreshResponse.headers);
      print('=============access_token==============');
      print(refreshResponse.headers['access_token']);
      print('=============refresh_token==============');
      print(refreshResponse.headers['refresh_token']);
      print('=============refreshResponse==============');

      if (refreshResponse.statusCode != 200) {
        logout();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginFragment()));
      } else {
        print('===========refreshSavedResponse================');

        print(storage.read(key: 'refreshToken'));
        print(storage.read(key: 'accessToken'));
        savedRefreshToken(refreshResponse.headers['access_token']!,
            refreshResponse.headers['refresh_token']!);
        print('저장 후 토큰 바뀌었는지 확인');
        print(storage.read(key: 'refreshToken'));
        print(storage.read(key: 'accessToken'));
        print('===========refreshSavedResponse================');

        final newBookmarkResponse = await http.get(
            Uri.parse(
                'http://ec2-13-209-203-81.ap-northeast-2.compute.amazonaws.com:8080/v1/plane/bookmark'),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "access_token": accessToken ?? "",
            });

        _bookmarkResponse = BookmarkResponse.fromJson(
            json.decode(utf8.decode(newBookmarkResponse.bodyBytes)));
        _bookmarkList = _bookmarkResponse.content;
      }
    } else {
      _bookmarkResponse = BookmarkResponse.fromJson(
          json.decode(utf8.decode(bookmarkResponse.bodyBytes)));
      _bookmarkList = _bookmarkResponse.content;
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

class BookmarkWidget extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkWidget({required this.bookmark, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    bookmark.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(bookmark.subject),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
