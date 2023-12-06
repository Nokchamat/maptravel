import 'package:flutter/material.dart';
import 'package:maptravel/dto/vo_plane_list.dart';
import 'package:maptravel/plane_detail/s_plane_detail.dart';

class PlaneWidget extends StatelessWidget {
  final PlaneList planeList;

  const PlaneWidget({required this.planeList, super.key});

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
                        planeList.userProfileImageUrl,
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
                      planeList.userNickname,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          planeList.country,
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
                          planeList.city,
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
                    builder: (context) => PlaneDetailScreen(planeId: planeList.planeId,)));
          },
          child: Image.network(
            planeList.thumbnailUrl,
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
                          planeList.subject,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          planeList.content,
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
                            child: Text("30"), //좋아요 카운트
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
                        child: Text(planeList.viewCount.toString()),
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
