import 'package:flutter/material.dart';

import '../dto/vo_place.dart';

class DetailPlaceWidget extends StatelessWidget {
  final Place place;

  const DetailPlaceWidget({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            itemCount: place.pictureUrlArray.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  place.pictureUrlArray[index],
                  fit: BoxFit.cover,
                ),
              );
            },
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
                    Row(
                      children: [
                        // const Icon(Icons.title),
                        Text(
                          place.subject,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // const Icon(Icons.description),
                        Text(
                          place.content,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.place),
                        Text(
                          place.address,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade200,
          height: 8,
        ),
      ],
    );
  }
}