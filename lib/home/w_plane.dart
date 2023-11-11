import 'package:flutter/material.dart';
import 'package:maptravel/s_plane_detail.dart';

import '../vo/vo_plane.dart';

class PlaneWidget extends StatelessWidget {
  final Plane plane;

  const PlaneWidget({required this.plane, super.key});

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
                    child: Image.network(
                      plane.user.profileImageUrl,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plane.user.nickname,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          plane.country,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        Text(
                          plane.city,
                          style: Theme.of(context).textTheme.bodyMedium,
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
                    builder: (context) => const PlaneDetailScreen()));
          },
          child: Image.network(
            plane.thumbnailUrl,
            width: double.infinity,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Text(
                plane.subject,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Text(plane.viewCount.toString()),
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
