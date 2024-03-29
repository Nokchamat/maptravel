import 'package:flutter/material.dart';

class SmallButtonWidget extends StatelessWidget {
  final String buttonText;
  final double width;
  final double height;

  const SmallButtonWidget(
      {super.key, required this.buttonText, this.width = 50, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
