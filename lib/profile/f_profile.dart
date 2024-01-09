import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/alert_dialog/confirmDialog.dart';
import 'package:maptravel/api/api_profile.dart';
import 'package:maptravel/api/common.dart';
import 'package:maptravel/common/constant/profile_constant.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/profile/s_email_verify.dart';
import 'package:maptravel/profile/s_my_plane.dart';
import 'package:maptravel/profile/s_update_profile.dart';
import 'package:maptravel/profile/w_profile_gesture_detector.dart';
import 'package:maptravel/s_main_page.dart';

import '../dto/vo_user.dart';
import '../sign/s_sign.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<ProfileFragment> {
  late Future<void> _apiFuture;
  late User _user;

  Future<void> waitAPI() async {
    String? isLogin = await getIsLogin();

    if (isLogin == null) {
      print('로그아웃 상태임 isLogin : $isLogin');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignScreen()));
    } else {
      print('로그인 상태임');
      String? accessToken;
      accessToken = await getAccessToken();
      if (accessToken != null) {
        try {
          http.Response response =
              await http.get(Uri.parse('$baseUrl/v1/user/myprofile'), headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "access_token": accessToken,
          });
          _user = User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        } catch (error) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignScreen()));
        }
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignScreen()));
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    _apiFuture = waitAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _apiFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return buildContent();
        }
      },
    );
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
            child: Stack(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(
                        ProfileConstant.profileImageRadius),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: _user.profileImageUrl.isEmpty
                        ? const Icon(
                            Icons.person,
                            size: 150,
                          )
                        : Image.network(
                            _user.profileImageUrl,
                            width: ProfileConstant.profileImageWidth,
                            height: ProfileConstant.profileImageHeight,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              _user.nickname,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProfileScreen(user: _user)));
            },
            child: const ProfileContainerWidget(text: "프로필 수정"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyPlane(userId: _user.id)));
            },
            child: const ProfileContainerWidget(text: "내가 작성한 여행"),
          ),
          if (!_user.isEmailVerify)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmailVerifyScreen()));
              },
              child: const ProfileContainerWidget(text: "이메일 인증하기"),
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LicensePage()),
              );
            },
            child: const ProfileContainerWidget(text: "오픈소스 라이센스"),
          ),
          GestureDetector(
            onTap: () async {
              bool confirmDelete = await confirmDialog(context, '회원 탈퇴하시겠습니까?');

              if (confirmDelete) {
                http.Response response = await withdrawAccount();

                if (response.statusCode == 200) {
                  await checkDialog(context, '회원 탈퇴가 완료되었습니다.');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false,
                  );
                } else {
                  textDialog(context,
                      '${json.decode(utf8.decode(response.bodyBytes))['message']}');
                }
              }
            },
            child: const ProfileContainerWidget(text: "회원 탈퇴"),
          ),
          GestureDetector(
            onTap: () {
              logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false,
              );
            },
            child: const ProfileContainerWidget(text: "로그아웃"),
          ),
        ],
      ),
    );
  }
}
