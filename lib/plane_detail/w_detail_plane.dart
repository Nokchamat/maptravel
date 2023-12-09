import 'package:flutter/material.dart';
import 'package:maptravel/dto/vo_plane.dart';

class DetailPlaneWidget extends StatelessWidget {
  final Plane plane;

  const DetailPlaneWidget({super.key, required this.plane});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.network(
            plane.thumbnailUrl,
            fit: BoxFit.cover,
          ),
        ),
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
                      plane.subject,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      plane.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
