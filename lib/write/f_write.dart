import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:maptravel/dto/vo_create_place_form.dart';
import 'package:maptravel/main.dart';
import 'package:maptravel/write/input_container.dart';
import 'package:maptravel/write/w_place.dart';
import 'package:maptravel/write/w_place_image.dart';

import '../alert_dialog/alert_dialog.dart';
import '../api/common.dart';
import '../common/secure_storage/secure_strage.dart';
import '../service/image_picker_service.dart';
import '../sign/s_sign.dart';

class WriteFragment extends StatefulWidget {
  const WriteFragment({super.key});

  @override
  State<WriteFragment> createState() => _WriteFragmentState();
}

class _WriteFragmentState extends State<WriteFragment> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final picker = ImagePickerService();
  XFile? selectedImage;

  void waitAPI() async {
    getIsLogin().then(
      (value) => {
        if (value == null)
          {
            print('logout'),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignScreen()))
          },
      },
    );
  }

  void validate() {
    if (_subjectController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _cityController.text.isEmpty) {
      showAlertDialog(context, '빈 칸이 있는지 확인해주세요.');

      return;
    }

    return;
  }

  void getData() async {
    var formData =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/v1/plane'));

    if (_subjectController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _cityController.text.isEmpty ||
        selectedImage == null) {
      showAlertDialog(context, '사진이나 내용을 확인해주세요.');

      return;
    }

    formData.fields.addAll({
      'subject': _subjectController.text,
      'content': _contentController.text,
      'country': _countryController.text,
      'city': _cityController.text,
    });
    formData.files.add(
        await http.MultipartFile.fromPath('thumbnail', selectedImage!.path));

    String? accessToken;
    accessToken = await getAccessToken();
    formData.headers['access_token'] = accessToken!;

    for (int i = 0; i < placeWidgetList.length; i++) {
      if (placeWidgetList[i] is PlaceWidget) {
        final PlaceWidget placeWidget = placeWidgetList[i] as PlaceWidget;
        CreatePlaceForm createPlaceForm = placeWidget.getData();

        if (createPlaceForm.subject.isEmpty ||
            createPlaceForm.content.isEmpty ||
            createPlaceForm.address.isEmpty ||
            createPlaceForm.pictureList.isEmpty) {
          showAlertDialog(context, '사진이나 내용을 확인해주세요.');

          return;
        }

        formData.fields.addAll({
          'createPlaceFormList[$i].subject': createPlaceForm.subject,
          'createPlaceFormList[$i].content': createPlaceForm.content,
          'createPlaceFormList[$i].address': createPlaceForm.address,
        });

        for (var picture in createPlaceForm.pictureList) {
          formData.files.add(await http.MultipartFile.fromPath(
              'createPlaceFormList[$i].pictureList', picture.path));
        }
      }
    }

    try {
      // 요청 보내기
      http.StreamedResponse response = await formData.send();

      if (response.statusCode == 200) {
        // 성공적으로 요청이 보내진 경우
        print('요청이 성공했습니다.');
        String responseData = await response.stream.bytesToString();
        print(responseData);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyApp()));
      } else {
        // 요청 실패한 경우
        print('요청 실패: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  late List<Widget> placeWidgetList = []; // 추가된 PlaceWidget을 저장하는 리스트
  @override
  void initState() {
    super.initState();
    waitAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          key: GlobalKey(),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('여행 등록하기', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                print('갤러리 클릭');
                final image = await picker.pickImage();

                setState(() {
                  selectedImage = image;
                });
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
                    child: selectedImage == null
                        ? const Text(
                            '썸내일을 선택해주세요.',
                            style: TextStyle(color: Colors.white),
                          )
                        : PlaceImageWidget(image: selectedImage!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            InputContainer(
              textController: _countryController,
              hintText: '나라 이름을 입력해주세요.',
              maxLines: 1,
            ),
            const SizedBox(height: 16.0),
            InputContainer(
              textController: _cityController,
              hintText: '도시 이름을 입력해주세요.',
              maxLines: 1,
            ),
            const SizedBox(height: 16.0),
            InputContainer(
              textController: _subjectController,
              hintText: '제목을 입력해주세요.',
              maxLines: 1,
            ),
            const SizedBox(height: 16.0),
            InputContainer(
              textController: _contentController,
              hintText: '내용을 입력해주세요.',
              maxLines: 8,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text('장소 등록하기', style: Theme.of(context).textTheme.labelLarge),
                IconButton(
                  onPressed: () {
                    setState(() {
                      placeWidgetList.add(PlaceWidget());
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                  ),
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(children: placeWidgetList),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                print('게시');
                getData();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const MyApp()));
              },
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text('게시'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
