import 'package:flutter/material.dart';
import 'package:maptravel/api/api_bookmark.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/dto/vo_bookmark.dart';
import 'package:maptravel/sign/f_login.dart';

class BookmarkFragment extends StatefulWidget {
  const BookmarkFragment({super.key});

  @override
  State<BookmarkFragment> createState() => _BookmarkFragment();
}

class _BookmarkFragment extends State<BookmarkFragment> {
  List<Bookmark> _bookmarkList = [];
  late BookmarkResponse _bookmarkResponse;

  void waitAPI() async {
    getIsLogin().then(
      (value) => {
        if (value == null)
          {
            print('logout 상태'),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginFragment()))
          },
      },
    );
    _bookmarkResponse = await getBookmark();
    _bookmarkList = _bookmarkResponse.content;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitAPI();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [
        ..._bookmarkList.map((bookmark) => BookmarkWidget(bookmark: bookmark))
      ],
    );
  }
}

class BookmarkWidget extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkWidget({required this.bookmark, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    bookmark.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(bookmark.subject),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
