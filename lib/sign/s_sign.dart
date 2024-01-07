import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/api/api_sign.dart';
import 'package:maptravel/s_main_page.dart';
import 'package:maptravel/write/input_container.dart';

import '../alert_dialog/alert_dialog.dart';
import '../api/common.dart';
import '../common/secure_storage/secure_strage.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordCheck = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  bool isLoginForm = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AnimatedContainer(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            duration: const Duration(
              milliseconds: 2,
            ),
            child: SizedBox(
              height: 30,
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  tabs: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isLoginForm ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isLoginForm ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                  isScrollable: true,
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  labelStyle: Theme.of(context).textTheme.labelLarge,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                  unselectedLabelColor: Colors.transparent,
                  unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
                  onTap: (index) {
                    setState(() {
                      isLoginForm = !isLoginForm;
                    });
                  },
                  splashBorderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InputContainer(
                textController: _email,
                hintText: 'Email',
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              InputContainer(
                textController: _password,
                hintText: 'Password',
                maxLines: 1,
                obscureText: true,
              ),
              const SizedBox(height: 8),
              isLoginForm
                  ? const SizedBox()
                  : Column(
                      children: [
                        InputContainer(
                          textController: _passwordCheck,
                          hintText: 'PasswordCheck',
                          maxLines: 1,
                          obscureText: true,
                        ),
                        const SizedBox(height: 8),
                        InputContainer(
                          textController: _name,
                          hintText: 'Name',
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        InputContainer(
                          textController: _nickname,
                          hintText: 'Nickname',
                          maxLines: 1,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
              isLoginForm
                  ? ElevatedButton(
                      onPressed: () async {
                        final response = await http.post(
                          Uri.parse('$baseUrl/v1/signin'),
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            "email": _email.text,
                            "password": _password.text,
                          }),
                        );

                        if (response.statusCode == 200) {
                          print('로그인 완료');
                          login(Token(
                            response.headers['access_token']!,
                            response.headers['refresh_token']!,
                          ));

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                            (route) => false,
                          );
                        } else {
                          // 로그인 실패 시 알럿 창 띄우기
                          print('로그인 실패');
                          showAlertDialog(
                              context,
                              json.decode(
                                  utf8.decode(response.bodyBytes))['message']);
                        }
                      },
                      child: const Text('로그인'),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        if (_email.text.isEmpty ||
                            _password.text.isEmpty ||
                            _passwordCheck.text.isEmpty ||
                            _name.text.isEmpty ||
                            _nickname.text.isEmpty) {
                          showAlertDialog(context, '빈 칸이 있는지 확인해주세요.');
                          return;
                        }
                        final RegExp emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(_email.text)) {
                          showAlertDialog(context, '이메일 형식이어야 합니다.');
                          return;
                        }
                        if (_password.text != _passwordCheck.text) {
                          showAlertDialog(context, '비밀번호가 일치하지 않습니다.');
                          return;
                        }
                        if (_name.text.length > 30) {
                          showAlertDialog(context, '이름을 확인해주세요.');
                          return;
                        }
                        if (_nickname.text.length > 15) {
                          showAlertDialog(context, '닉네임은 10글자 미만으로 작성해주세요.');
                          return;
                        }

                        final response = await http.post(
                          Uri.parse('$baseUrl/v1/signup'),
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            "email": _email.text,
                            "password": _password.text,
                            "name": _name.text,
                            "nickname": _nickname.text,
                          }),
                        );

                        if (response.statusCode == 200) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignScreen()));
                          showAlertDialog(context, '회원가입 완료');
                        } else {
                          // 로그인 실패 시 알럿 창 띄우기
                          print('회원가입 실패');
                          print('===========================');
                          showAlertDialog(
                              context,
                              json.decode(
                                  utf8.decode(response.bodyBytes))['message']);
                          print('===========================');
                        }
                      },
                      child: const Text('회원가입'),
                    ),
              ElevatedButton(
                onPressed: () async {
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                  if(googleUser != null) {
                    print(googleUser.displayName);
                    print(googleUser.email);
                    print(googleUser.id);

                    final response = await http.post(
                      Uri.parse('$baseUrl/v1/signin/google'),
                      headers: <String, String>{
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({
                        "displayName": googleUser.displayName,
                        "email": googleUser.email,
                        "id": googleUser.id,
                      }),
                    );

                    if (response.statusCode == 200) {
                      print('로그인 완료');
                      login(Token(
                        response.headers['access_token']!,
                        response.headers['refresh_token']!,
                      ));

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                            (route) => false,
                      );
                    } else {
                      // 로그인 실패 시 알럿 창 띄우기
                      print('로그인 실패 : ${response.statusCode}');
                      print('로그인 실패 : ${response.body}');
                      showAlertDialog(
                          context,
                          json.decode(
                              utf8.decode(response.bodyBytes))['message']);
                    }
                  }
                },
                child: const Text('Google 로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
