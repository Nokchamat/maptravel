import 'package:flutter/material.dart';
import 'package:maptravel/dto/vo_plane_list.dart';

import '../api/common.dart';
import '../common/secure_storage/secure_strage.dart';
import '../plane_detail/s_plane_detail.dart';
import '../sign/s_sign.dart';
import 'package:http/http.dart' as http;

class GridPlaneByUserIdWidget extends StatefulWidget {
  final PlaneList plane;
  final VoidCallback onRemove;

  const GridPlaneByUserIdWidget(
      {required this.plane, super.key, required this.onRemove});

  @override
  State<GridPlaneByUserIdWidget> createState() =>
      _GridPlaneByUserIdWidgetState();
}

class _GridPlaneByUserIdWidgetState extends State<GridPlaneByUserIdWidget> {
  late bool isLikes;
  late bool isBookmark;

  @override
  void initState() {
    super.initState();
    isLikes = widget.plane.isLikes;
    isBookmark = widget.plane.isBookmark;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaneDetailScreen(
                          planeId: widget.plane.planeId,
                        )));
          },
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              widget.plane.thumbnailUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              widget.plane.subject,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
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
                                builder: (context) => const SignScreen()))
                      }
                    else
                      {print('null 아님'), accessToken = value}
                  });

              if (isLikes) {
                await http
                    .delete(
                        Uri.parse(
                            '$baseUrl/v1/plane/${widget.plane.planeId}/likes'),
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
                            '$baseUrl/v1/plane/${widget.plane.planeId}/likes'),
                        headers: {
                          "Content-Type": "application/json",
                          "Accept": "application/json",
                          "access_token": accessToken!,
                        })
                    .then((value) => {
                          if (value.statusCode == 200)
                            {
                              setState(() {
                                isLikes = !isLikes;
                              }),
                            }
                          else
                            {
                              print('${value.statusCode} : $value'),
                            }
                        })
                    .catchError((onError) => print(onError));
              }
            },
            icon: isLikes
                ? const Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    size: 30,
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 33,
          child: IconButton(
            onPressed: () async {
              String? accessToken;
              await getAccessToken().then((value) => {
                    if (value == null)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignScreen()))
                      }
                    else
                      {accessToken = value}
                  });

              if (isBookmark) {
                await http
                    .delete(
                        Uri.parse(
                            '$baseUrl/v1/plane/${widget.plane.planeId}/bookmark'),
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
                            '$baseUrl/v1/plane/${widget.plane.planeId}/bookmark'),
                        headers: {
                          "Content-Type": "application/json",
                          "Accept": "application/json",
                          "access_token": accessToken!,
                        })
                    .then((value) => {
                          if (value.statusCode == 200)
                            {
                              setState(() {
                                isBookmark = !isBookmark;
                              }),
                            }
                          else
                            {
                              print('${value.statusCode} : $value'),
                            }
                        })
                    .catchError((onError) => print(onError));
              }
            },
            icon: isBookmark
                ? const Icon(
                    Icons.bookmark,
                    size: 30,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.bookmark_border_outlined,
                    size: 30,
                  ),
          ),
        )
      ],
    );
  }
}
