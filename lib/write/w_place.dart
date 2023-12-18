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
            color: Colors.grey[200],
            width: double.infinity,
            height: 320,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: widget.selectedImages.isEmpty
                    ? Icon(
                        Icons.add_a_photo,
                        size: 120,
                        color: Colors.grey[400],
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
        TextField(
          controller: widget.subjectController,
          maxLines: 1,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '제목을 입력해주세요.',
          ),
        ),
        Container(
          color: Colors.grey.shade300,
          height: 1,
        ),
        TextField(
          controller: widget.addressController,
          maxLines: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '주소를 입력해주세요.',
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.grey.shade300,
          height: 1,
        ),
        TextField(
          controller: widget.contentController,
          maxLines: 5,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '내용을 입력해주세요.',
          ),
        ),
        Container(
          color: Colors.grey.shade300,
          height: 1,
        ),
      ],
    );
  }
}
