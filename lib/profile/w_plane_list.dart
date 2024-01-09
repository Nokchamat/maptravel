import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/alert_dialog/confirmDialog.dart';
import 'package:maptravel/dto/vo_plane_list.dart';

import '../api/api_home.dart';
import '../plane_detail/s_plane_detail.dart';
import '../sign/s_sign.dart';

class GridPlaneWidget extends StatelessWidget {
  final PlaneList plane;
  final VoidCallback onRemove;

  const GridPlaneWidget(
      {required this.plane, super.key, required this.onRemove});

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
                          planeId: plane.planeId,
                        )));
          },
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              plane.thumbnailUrl,
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
              plane.subject,
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
                // showDialog를 사용하여 AlertDialog 표시
                bool confirmDelete = await confirmDialog(context, '삭제하시겠습니까?');

                if (confirmDelete == true) {
                  // 사용자가 확인을 선택했을 때 실행될 코드
                  http.Response response =
                      await removePlane(plane.planeId).catchError(
                    (onError) => {
                      print(onError),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignScreen()),
                      ),
                    },
                  );

                  if (response.statusCode == 200) {
                    onRemove();
                  }
                }
              },
              icon: const Icon(
                Icons.remove_circle,
                size: 30,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.green,
                    offset: Offset(1.0, 1.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
