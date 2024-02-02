import 'package:flutter/material.dart';
import 'package:maptravel/alert_dialog/confirmDialog.dart';
import 'package:maptravel/api/api_comment.dart';

class AddCommentWidget extends StatefulWidget {
  final int planeId;
  final VoidCallback? refreshCommentScreen;
  const AddCommentWidget({super.key, required this.planeId, this.refreshCommentScreen});

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      maxLines: 1,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '댓글을 입력해주세요.',
          suffixIcon: IconButton(
            onPressed: () async {
              var response = await createComment(widget.planeId, textEditingController.text);

              if(response.statusCode == 200) {
                widget.refreshCommentScreen!();
              } else {
                textDialog(context, "에러가 발생했습니다.\n다시 시도해주세요.");
              }

              textEditingController.text = '';
            },
            icon: const Icon(Icons.send),
          )),
    );
  }
}
