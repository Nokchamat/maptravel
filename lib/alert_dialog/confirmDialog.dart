import 'package:flutter/material.dart';

Future<bool> confirmDialog(context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('확인'),
        content: const Text('삭제하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // 취소 버튼을 누르면 false 반환
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // 확인 버튼을 누르면 true 반환
            },
            child: const Text('확인'),
          ),
        ],
      );
    },
  );
}

void textDialog(context, text) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('확인'),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // 확인 버튼을 누르면 true 반환
            },
            child: const Text('확인'),
          ),
        ],
      );
    },
  );
}