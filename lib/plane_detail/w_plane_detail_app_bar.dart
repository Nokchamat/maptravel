import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/api/common.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/plane_detail/map/s_map.dart';

import '../dto/vo_plane.dart';
import '../sign/s_sign.dart';

class PlaneDetailAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const PlaneDetailAppBarWidget({
    super.key,
    required this.plane,
    required this.context,
    required this.appBar,
  });

  final Plane plane;
  final BuildContext context;
  final AppBar appBar;

  @override
  State<PlaneDetailAppBarWidget> createState() =>
      _PlaneDetailAppBarWidgetState();

  @override
  Size get preferredSize => appBar.preferredSize;
}

class _PlaneDetailAppBarWidgetState extends State<PlaneDetailAppBarWidget> {
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
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      widget.plane.userProfileImageUrl,
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
                    widget.plane.userNickname,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.plane.country,
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
                        widget.plane.city,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapScreen()));
                },
                icon: const Icon(Icons.map),
              ),
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
                                    builder: (context) => const SignScreen()))
                          }
                        else
                          {print('null 아님'), accessToken = value}
                      });

                  if (isLikes) {
                    await http
                        .delete(
                            Uri.parse(
                                '$baseUrl/v1/plane/${widget.plane.id}/likes'),
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
                                '$baseUrl/v1/plane/${widget.plane.id}/likes'),
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
              IconButton(
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
                                '$baseUrl/v1/plane/${widget.plane.id}/bookmark'),
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
                                '$baseUrl/v1/plane/${widget.plane.id}/bookmark'),
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
          )
        ],
      ),
    );
  }

  Size get preferredSize => Size.fromHeight(widget.appBar.preferredSize.height);
}
