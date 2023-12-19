import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maptravel/dto/vo_create_place_form.dart';
import 'package:maptravel/dto/vo_google_place.dart';
import 'package:maptravel/service/image_picker_service.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/write/d_search_address.dart';
import 'package:maptravel/write/w_place_images.dart';

import '../alert_dialog/alert_dialog.dart';
import '../api/api_key.dart';

class PlaceWidget extends StatefulWidget {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController;
  final TextEditingController cityController;
  final List<XFile> selectedImages = [];

  PlaceWidget(
      {super.key,
      required this.countryController,
      required this.cityController});

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
                widget.selectedImages.clear();
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
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            size: 120,
                            color: Colors.grey[400],
                          ),
                          const Positioned(
                            child: Text(
                              '사진을 선택해주세요. 최대 5개까지 입니다.',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
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
                onPressed: () async {
                  if (widget.addressController.text.isNotEmpty) {
                    print(
                        'searchLocation!! : ${widget.addressController.text}');
                    String key = googlePlaceApiKey;

                    try {
                      var response = await http.post(
                        Uri.parse(
                            'https://places.googleapis.com/v1/places:searchText'),
                        headers: {
                          'Content-Type': 'application/json',
                          'X-Goog-Api-Key': key,
                          'X-Goog-FieldMask':
                              'places.formattedAddress,places.displayName,places.location,places.addressComponents',
                          'Accept-Language': 'ko',
                        },
                        body: json.encode({
                          'textQuery': widget.addressController.text,
                        }),
                      );

                      if (response.statusCode == 200) {
                        // 요청 성공
                        var jsonResponse = json.decode(response.body);
                        print('Response: $jsonResponse');
                        List<GooglePlace> places = (jsonResponse['places']
                                as List)
                            .map((jsonPlace) => GooglePlace.fromJson(jsonPlace))
                            .toList();
                        searchAddressDialog(
                          context,
                          places,
                          widget.addressController,
                          widget.countryController,
                          widget.cityController,
                        );
                      } else {
                        // 요청 실패
                        print(
                            'Request failed with status: ${response.statusCode}');
                        print('Request failed with status: ${response.body}');
                      }
                    } catch (e) {
                      // 에러 처리
                      print('Error: $e');
                    }
                  }
                },
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
