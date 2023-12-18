import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:maptravel/dto/vo_create_place_form.dart';
import 'package:maptravel/main.dart';
import 'package:maptravel/write/w_place.dart';
import 'package:maptravel/write/w_place_image.dart';
import 'package:maptravel/write/w_small_button.dart';

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
  final PageController _pageController = PageController();
  bool isPlanePage = true;
  final picker = ImagePickerService();
  XFile? selectedImage;
  int currentIndex = 1;

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

    placeWidgetList.add(PlaceWidget());
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45.0), // 높이 조정
        child: AppBar(
          title: isPlanePage ? const Text('여행 등록하기') : const Text('장소 등록하기'),
          surfaceTintColor: Colors.white,
          shadowColor: Colors.green[100],
          leading: isPlanePage
              ? null
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlanePage = true;
                    });
                  },
                  child: const SmallButtonWidget(buttonText: '이전'),
                ),
          actions: isPlanePage
              ? [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPlanePage = false;
                      });
                    },
                    child: const SmallButtonWidget(buttonText: '다음'),
                  )
                ]
              : [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        getData();
                      });
                    },
                    child: const SmallButtonWidget(buttonText: '게시'),
                  )
                ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0), // Divider의 높이
            child: Divider(
              height: 1,
              color: Colors.grey, // Divider 색상
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: isPlanePage ? writePlaneWidget() : writePlaceWidget(),
      ),
    );
  }

  Widget writePlaneWidget() {
    return Column(
      key: GlobalKey(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            print('갤러리 클릭');
            final image = await picker.pickImage();

            setState(() {
              selectedImage = image;
            });
          },
          child: Container(
            color: Colors.grey[200],
            key: UniqueKey(),
            width: double.infinity,
            height: 320,
            child: Center(
              child: selectedImage == null
                  ? Icon(
                      Icons.add_a_photo,
                      size: 120,
                      color: Colors.grey[400],
                    )
                  : PlaceImageWidget(image: selectedImage!),
            ),
          ),
        ),
        TextField(
          controller: _subjectController,
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
          controller: _subjectController,
          maxLines: 8,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '내용을 입력해주세요.',
          ),
        ),
        Container(
          color: Colors.grey.shade300,
          height: 1,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget writePlaceWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
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
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (placeWidgetList.length > 1) {
                        placeWidgetList.remove(
                            placeWidgetList[placeWidgetList.length - 1]);
                      }
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        currentIndex = _pageController.page!.toInt() + 1;
                      });
                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _pageController.animateToPage(
                      (_pageController.page?.toInt())! - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    setState(() {
                      currentIndex = _pageController.page!.toInt() + 1;
                    });
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _pageController.animateToPage(
                      (_pageController.page?.toInt())! + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    setState(() {
                      currentIndex = _pageController.page!.toInt() + 1;
                    });
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('$currentIndex/${placeWidgetList.length}'),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: placeWidgetList.length,
            itemBuilder: (BuildContext context, int index) {
              return placeWidgetList[index];
            },
          ),
        ),
      ],
    );
  }
}
