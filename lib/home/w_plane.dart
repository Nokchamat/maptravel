import 'package:flutter/material.dart';
import 'package:maptravel/home/s_plane_detail.dart';
import 'package:maptravel/home/vo/vo_plane.dart';

class PlaneWidget extends StatelessWidget {
  final Plane plane;

  const PlaneWidget({required this.plane, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: Image.network(
                  plane.user.thumbnailUrl,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            Text(
              plane.user.nickname,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PlaneDetailScreen()));
          },
          child: Image.network(
            plane.thumbnailUrl,
            width: double.infinity,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_outline,
                          size: 30,
                        )),
                    Positioned.fill(
                      bottom: -3,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(plane.likeCount.toString()),
                      ),
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border_outlined,
                      size: 30,
                    )),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    size: 30,
                    Icons.visibility_outlined,
                  ),
                ),
                Positioned.fill(
                  bottom: -3,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(plane.viewCount.toString()),
                  ),
                ),
              ],
            )
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
