import 'package:flutter/material.dart';
import 'package:maptravel/vo/dummy.dart';
import 'package:maptravel/vo/vo_plane.dart';

class BookmarkFragment extends StatefulWidget {
  const BookmarkFragment({super.key});

  @override
  State<BookmarkFragment> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<BookmarkFragment> {
  late List<Plane> _planeList;

  @override
  void initState() {
    _planeList = planeList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [..._planeList.map((e) => BookmarkWidget(plane: e))],
    );
  }
}

class BookmarkWidget extends StatelessWidget {
  final Plane plane;

  const BookmarkWidget({required this.plane, super.key});

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
                    plane.thumbnailUrl,
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
                  child: Text(plane.subject),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
