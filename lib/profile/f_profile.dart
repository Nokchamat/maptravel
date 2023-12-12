import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/api/common.dart';
import 'package:maptravel/common/constant/profile_constant.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/main.dart';
import 'package:maptravel/profile/s_update_profile.dart';

import '../dto/vo_user.dart';
import '../sign/f_login.dart';

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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginFragment()));
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
                    child: Image.network(
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
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.grey.shade200),
                bottom: BorderSide(color: Colors.grey.shade200),
              )),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text('프로필 수정'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                (route) => false,
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text('로그아웃'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}