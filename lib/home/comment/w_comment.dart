import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/alert_dialog/confirmDialog.dart';
import 'package:maptravel/api/api_comment.dart';

import '../../dto/vo_comment.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final VoidCallback? refreshCommentScreen;

  const CommentWidget({super.key, required this.comment, this.refreshCommentScreen});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    widget.comment.profileImageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.comment.userNickname,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              widget.comment.getCreatedAtDateTime(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                      if (widget.comment.isMine)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () async {
                              bool check =
                                  await confirmDialog(context, "댓글을 삭제하시겠습니까?");

                              if (check) {
                                http.Response response =
                                    await removeComment(widget.comment.id);
                                if (response.statusCode == 200) {
                                  widget.refreshCommentScreen!();
                                } else {
                                  textDialog(
                                      context, "삭제에 실패했습니다. 재시도하거나 문의해주세요.");
                                }
                              }
                            },
                            child: const Icon(Icons.close),
                          ),
                        )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      widget.comment.comment,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12)
      ],
    );
  }
}
