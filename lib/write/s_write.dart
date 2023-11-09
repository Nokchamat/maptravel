import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  late String _subject;
  late String _content;

  late List<Widget> placeWidgetList = []; // 추가된 PlaceWidget을 저장하는 리스트

  @override
  void initState() {
    _subject = "";
    _content = "";
    placeWidgetList.add(PlaceWidget());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  controller: _subjectController,
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
                  controller: _contentController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '내용을 입력해주세요.',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Container(
                  child: Text(
                    '장소 등록하기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        placeWidgetList.add(PlaceWidget());
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline,),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var place in placeWidgetList) place,
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 여기에 게시 버튼을 눌렀을 때 수행할 동작을 추가하세요.
                String topic = _subjectController.text;
                String content = _contentController.text;
                // 주제와 내용을 어딘가에 저장하거나 활용하는 로직을 추가할 수 있습니다.
              },
              child: Text('게시'),
            ),
          ],
        ),
      ),
    );
  }

  Widget PlaceWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            'https://images.unsplash.com/photo-1454391304352-2bf4678b1a7a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D',
            height: 300,
            width: 300,
          ),
        ),
        Container(
          width: 300,
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
              controller: _subjectController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '제목을 입력해주세요.',
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          width: 300,
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
              controller: _contentController,
              maxLines: 8,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '내용을 입력해주세요.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
