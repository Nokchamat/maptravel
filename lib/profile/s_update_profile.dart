import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:maptravel/alert_dialog/alert_dialog.dart';
import 'package:maptravel/api/api_profile.dart';
import 'package:maptravel/dto/vo_user.dart';

import '../common/constant/profile_constant.dart';
import '../main.dart';
import '../service/image_picker_service.dart';
import '../write/input_container.dart';

class UpdateProfileScreen extends StatefulWidget {
  final User user;

  const UpdateProfileScreen({super.key, required this.user});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nickname = TextEditingController();
  final picker = ImagePickerService();
  XFile? selectedImage;

  @override
  void initState() {
    nickname.text = widget.user.nickname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () async {
                if (widget.user.nickname != nickname.text) {
                  http.StreamedResponse response =
                      await updateNickname(nickname.text);
                  if (response.statusCode == 200) {
                    print(response.statusCode);
                    print('닉네임 업데이트 완료');
                  } else {
                    print('닉네임 업데이트 실패 : ${response.statusCode}');

                    showAlertDialog(context, '닉네임 수정에 실패했습니다.');
                    return;
                  }
                }

                if (selectedImage != null) {
                  http.StreamedResponse response =
                      await updateProfile(selectedImage);
                  if (response.statusCode == 200) {
                    print(response.statusCode);
                    print('프로필 이미지 업데이트 완료');
                  } else {
                    print('프로필 이미지 업데이트 실패 : ${response.statusCode}');

                    showAlertDialog(context, '프로필 이미지 수정에 실패했습니다.');
                    return;
                  }
                }

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 5),
              child: GestureDetector(
                onTap: () async {
                  print('갤러리 클릭');
                  final image = await picker.pickImage();

                  setState(() {
                    selectedImage = image;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(
                            ProfileConstant.profileImageRadius),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: selectedImage == null
                            ? widget.user.profileImageUrl.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 150,
                                  )
                                : Image.network(
                                    widget.user.profileImageUrl,
                                    width: ProfileConstant.profileImageWidth,
                                    height: ProfileConstant.profileImageHeight,
                                    fit: BoxFit.cover,
                                  )
                            : Image.file(
                                File(selectedImage!.path),
                                width: ProfileConstant.profileImageWidth,
                                height: ProfileConstant.profileImageHeight,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.photo_camera,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputContainer(
                textController: nickname,
                maxLines: 1,
                hintText: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
