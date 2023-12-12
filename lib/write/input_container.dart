import 'package:flutter/material.dart';

class InputContainer extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final int maxLines;
  bool obscureText;

  InputContainer({
    super.key,
    this.obscureText = false,
    required this.textController,
    required this.hintText,
    required this.maxLines,
  });

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          obscureText: widget.obscureText,
          controller: widget.textController,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
          ),
        ),
      ),
    );
  }
}
