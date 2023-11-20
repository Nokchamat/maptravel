import 'package:flutter/material.dart';
import 'package:maptravel/api/api_sign.dart';
import 'package:maptravel/home/f_home.dart';
import 'package:maptravel/main.dart';

import '../common/secure_storage/secure_strage.dart';

class LoginFragment extends StatefulWidget {
  const LoginFragment({super.key});

  @override
  State<LoginFragment> createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await signIn(_email.text, _password.text).catchError(
                  (onError) {
                    print(onError);
                  },
                ).then(
                  (token) => {
                    print('token'),
                    login(token),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))
                  },
                );
              },
              child: Text('로그인 하기'),
            ),
            ElevatedButton(
              onPressed: () async {
                await signIn(_email.text, _password.text).catchError(
                  (onError) {
                    print(onError);
                  },
                ).then(
                  (token) => {
                    login(token),
                  },
                );
              },
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
