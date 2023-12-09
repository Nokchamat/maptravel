import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/dto/vo_plane_list.dart';
import 'package:maptravel/plane_detail/s_plane_detail.dart';

import '../api/common.dart';
import '../common/secure_storage/secure_strage.dart';
import '../sign/f_login.dart';

class PlaneWidget extends StatefulWidget {
  final PlaneList planeList;

  const PlaneWidget({required this.planeList, super.key});

  @override
  State<PlaneWidget> createState() => _PlaneWidgetState();
}

class _PlaneWidgetState extends State<PlaneWidget> {
  late bool isLikes;
  late bool isBookmark;

  @override
  void initState() {
    super.initState();
    isLikes = widget.planeList.isLikes;
    isBookmark = widget.planeList.isBookmark;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.planeList.userProfileImageUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.planeList.userNickname,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.planeList.country,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        Text(
                          widget.planeList.city,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaneDetailScreen(
                          planeId: widget.planeList.planeId,
                        )));
          },
          child: Image.network(
            widget.planeList.thumbnailUrl,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.planeList.subject,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          widget.planeList.content,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            IconButton(
                              onPressed: () async {
                                print('좋아요 누름');

                                String? accessToken;
                                await getAccessToken().then((value) => {
                                      if (value == null)
                                        {
                                          print('null'),
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginFragment()))
                                        }
                                      else
                                        {print('null 아님'), accessToken = value}
                                    });

                                if (isLikes) {
                                  await http
                                      .delete(
                                          Uri.parse(
                                              '$baseUrl/v1/plane/${widget.planeList.planeId}/likes'),
                                          headers: {
                                            "Content-Type": "application/json",
                                            "Accept": "application/json",
                                            "access_token": accessToken!,
                                          })
                                      .then((value) => {
                                            print(value.statusCode),
                                            setState(() {
                                              isLikes = !isLikes;
                                            }),
                                          })
                                      .catchError((onError) => print(onError));
                                } else {
                                  await http
                                      .post(
                                          Uri.parse(
                                              '$baseUrl/v1/plane/${widget.planeList.planeId}/likes'),
                                          headers: {
                                            "Content-Type": "application/json",
                                            "Accept": "application/json",
                                            "access_token": accessToken!,
                                          })
                                      .then((value) => {
                                            print(value.statusCode),
                                            setState(() {
                                              isLikes = !isLikes;
                                            }),
                                          })
                                      .catchError((onError) => print(onError));
                                }
                              },
                              icon: isLikes
                                  ? const Icon(
                                      Icons.favorite,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.favorite_outline,
                                      size: 30,
                                    ),
                            ),
                            Positioned.fill(
                              bottom: -3,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  widget.planeList.likesCount.toString(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ), //좋아요 카운트
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                          size: 30,
                        )),
                    IconButton(
                      onPressed: () async {
                        String? accessToken;
                        await getAccessToken().then((value) => {
                              if (value == null)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginFragment()))
                                }
                              else
                                {accessToken = value}
                            });

                        if (isBookmark) {
                          await http
                              .delete(
                                  Uri.parse(
                                      '$baseUrl/v1/plane/${widget.planeList.planeId}/bookmark'),
                                  headers: {
                                    "Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "access_token": accessToken!,
                                  })
                              .then((value) => {
                                    print(value.statusCode),
                                    setState(() {
                                      isBookmark = !isBookmark;
                                    }),
                                  })
                              .catchError((onError) => print(onError));
                        } else {
                          await http
                              .post(
                                  Uri.parse(
                                      '$baseUrl/v1/plane/${widget.planeList.planeId}/bookmark'),
                                  headers: {
                                    "Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "access_token": accessToken!,
                                  })
                              .then((value) => {
                                    print(value.statusCode),
                                    setState(() {
                                      isBookmark = !isBookmark;
                                    }),
                                  })
                              .catchError((onError) => print(onError));
                        }
                      },
                      icon: isBookmark
                          ? const Icon(
                              Icons.bookmark,
                              size: 30,
                            )
                          : const Icon(
                              Icons.bookmark_border_outlined,
                              size: 30,
                            ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        size: 30,
                        Icons.visibility_outlined,
                      ),
                    ),
                    Positioned.fill(
                      bottom: -3,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          widget.planeList.viewCount.toString(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        Container(
          color: Colors.grey.shade200,
          height: 8,
        )
      ],
    );
  }
}
