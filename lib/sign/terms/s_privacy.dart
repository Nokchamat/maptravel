import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('개인정보 수집'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  children: [
                    TextSpan(
                      text: '[개인정보 수집 및 이용 동의]\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Maptravel은 다음과 같이 개인정보를 수집 및 이용하고 있습니다.\n\n',
                    ),
                    TextSpan(
                      text: '- 수집 및 이용 목적:\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '회원 가입, 서비스 제공, 이용자 식별, 부정이용 방지, 공지사항 전달\n',
                    ),
                    // 나머지 항목들도 RichText를 통해 추가할 수 있습니다.
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '동의를 거부할 권리가 있으나, 동의를 거부할 경우 회원가입이 불가능 합니다.\n'
                '외부 계정을 이용하는 경우 이용자가 동의한 범위 내에서만 개인정보를 제공받고 처리합니다.\n'
                '이벤트 등 프로모션 알림 전송을 위해 선택적으로 개인정보를 이용할 수 있습니다.\n'
                '※ 그 외의 사항 및 자동 수집 정보와 관련된 사항은 개인정보처리방침을 따릅니다.',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
