import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlaceImageWidget extends StatefulWidget {
  final XFile image;

  const PlaceImageWidget({super.key, required this.image});

  @override
  State<PlaceImageWidget> createState() => _PlaceImageWidgetState();
}

class _PlaceImageWidgetState extends State<PlaceImageWidget> {
  late XFile _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: SizedBox(
        height: double.infinity,
        width: 310,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(_image.path), // XFile을 File로 변환
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
