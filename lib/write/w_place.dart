import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maptravel/dto/vo_create_place_form.dart';
import 'package:maptravel/service/image_picker_service.dart';
import 'package:maptravel/write/w_place_images.dart';

import '../alert_dialog/alert_dialog.dart';

class PlaceWidget extends StatefulWidget {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final List<XFile> selectedImages = [];

  PlaceWidget({super.key});

  CreatePlaceForm getData() {
    return CreatePlaceForm(
      subject: subjectController.text,
      content: contentController.text,
      address: addressController.text,
      pictureList: selectedImages,
    );
  }

  @override
  State<PlaceWidget> createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  final picker = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            print('갤러리 클릭');
            final images = await picker.pickImages();

            if (images.length > 5) {
              showAlertDialog(context, '사진은 최대 5장까지 입니다.');
            } else {
              setState(() {
                widget.selectedImages.addAll(images);
              });
            }
          },
          child: Container(
            key: UniqueKey(),
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: widget.selectedImages.isEmpty
                    ? const Text(
                        '사진을 선택해주세요.',
                        style: TextStyle(color: Colors.white),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            widget.selectedImages.length,
                            (index) => PlaceImagesWidget(
                              image: widget.selectedImages[index],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
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
              controller: widget.subjectController,
              maxLines: 1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '제목을 입력해주세요.',
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
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
              controller: widget.addressController,
              maxLines: 1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '주소를 입력해주세요.',
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            print('검색 클릭 : ${widget.addressController.text}');

          },
          icon: const Icon(
            Icons.search,
            size: 30,
          ),
        ),
        const SizedBox(height: 16.0),
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
              controller: widget.contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '내용을 입력해주세요.',
              ),
            ),
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
