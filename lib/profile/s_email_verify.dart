import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maptravel/alert_dialog/confirmDialog.dart';
import 'package:maptravel/api/api_profile.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/write/w_small_button.dart';

import '../s_main_page.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final TextEditingController _emailVerifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이메일 인증'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _emailVerifyController,
            maxLines: 1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '이메일 인증코드를 입력해주세요.',
            ),
          ),
          GestureDetector(
            onTap: () async {
              http.Response response =
                  await verifyEmail(_emailVerifyController.text);

              if (response.statusCode == 200) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false,
                );
                textDialog(context, '인증이 완료됐습니다.');
              } else {
                textDialog(context, '${json.decode(utf8.decode(response.bodyBytes))['message']}');
              }
            },
            child: const SmallButtonWidget(
              buttonText: '인증',
            ),
          ),
          GestureDetector(
            onTap: () async {
              http.Response response = await reSendEmail();

              if (response.statusCode == 200) {
                textDialog(context, '메일 발송이 완료됐습니다.');
              } else {
                textDialog(context, '${json.decode(utf8.decode(response.bodyBytes))['message']}');
              }
            },
            child: const SmallButtonWidget(
              buttonText: '인증코드 재발급',
              width: 130,
            ),
          )
        ],
      ),
    );
  }
}
