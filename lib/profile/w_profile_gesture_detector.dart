import 'package:flutter/material.dart';

class ProfileContainerWidget extends StatelessWidget {
  final String text;

  const ProfileContainerWidget({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Text(text),
      ),
    );
  }
}
