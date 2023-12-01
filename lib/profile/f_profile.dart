import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/common/constant/profile_constant.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';

import '../dto/vo_user.dart';
import '../sign/f_login.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<ProfileFragment> {
  late User _user = new User(
    id: 1,
    nickname: 'nickname',
    profileImageUrl: 'profileImageUrl',
    followerCount: 1,
    isEmailVerify: false,
  );

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

    final profileResponse = await http.get(
        Uri.parse(
            'http://ec2-13-209-203-81.ap-northeast-2.compute.amazonaws.com:8080/v1/user/myprofile'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "access_token": accessToken ?? "",
        });

    if (profileResponse.statusCode == 500) {
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

        final newProfileResponse = await http.get(
            Uri.parse(
                'http://ec2-13-209-203-81.ap-northeast-2.compute.amazonaws.com:8080/v1/user/myprofile'),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "access_token": accessToken ?? "",
            });

        _user = User.fromJson(
            json.decode(utf8.decode(newProfileResponse.bodyBytes)));
      }
    } else {
      _user =
          User.fromJson(json.decode(utf8.decode(profileResponse.bodyBytes)));
    }

    setState(() {});
  }

  @override
  void initState() {
    waitAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius:
                    BorderRadius.circular(ProfileConstant.profileImageRadius),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  _user.profileImageUrl,
                  width: ProfileConstant.profileImageWidth,
                  height: ProfileConstant.profileImageHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey.shade200),
              bottom: BorderSide(color: Colors.grey.shade200),
            )),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내 정보',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey.shade200),
              bottom: BorderSide(color: Colors.grey.shade200),
            )),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '로그아웃',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      logout();
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
