import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/api/api_bookmark.dart';

import '../dto/vo_bookmark.dart';
import '../sign/f_login.dart';

class BookmarkWidget extends StatelessWidget {
  final Bookmark bookmark;
  final VoidCallback onRemove;

  const BookmarkWidget({required this.bookmark, super.key, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            bookmark.thumbnailUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              bookmark.subject,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              onPressed: () async {
                http.Response response = await removeBookmark(bookmark.planeId)
                    .catchError((onError) => {
                          print(onError),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginFragment())),
                        });

                if (response.statusCode == 200) {
                  onRemove();
                }
              },
              icon: const Icon(Icons.bookmark,
                  size: 30,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.green,
                      offset: Offset(1.0, 1.0),
                    )
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
