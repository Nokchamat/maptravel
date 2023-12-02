import 'package:flutter/material.dart';
import 'package:maptravel/write/w_place.dart';

class WriteFragment extends StatefulWidget {
  const WriteFragment({super.key});

  @override
  State<WriteFragment> createState() => _WriteFragmentState();
}

class _WriteFragmentState extends State<WriteFragment> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late int placeLength;

  late List<Widget> placeWidgetList = []; // 추가된 PlaceWidget을 저장하는 리스트
  @override
  void initState() {
    placeLength = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('여행 등록하기', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
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
                Text('장소 등록하기', style: Theme.of(context).textTheme.labelLarge),
                IconButton(
                  onPressed: () {
                    setState(() {
                      placeLength++;
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
                child: Column(
                  children: List.generate(
                    placeLength,
                    (index) => const PlaceWidget(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('게시');


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
