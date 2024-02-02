import 'package:flutter/material.dart';
import 'package:maptravel/home/comment/w_add_comment.dart';
import 'package:maptravel/home/comment/w_comment.dart';

import '../../api/api_comment.dart';
import '../../common/secure_storage/secure_strage.dart';
import '../../dto/vo_comment.dart';
import '../../sign/s_sign.dart';

class CommentScreen extends StatefulWidget {
  final int planeId;

  const CommentScreen({super.key, required this.planeId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late CommentResponse _commentResponse;
  List<Comment> _commentList = [];

  void waitAPI() async {
    String? isLogin = await getIsLogin();

    if (isLogin == null) {
      print('로그아웃 상태임 isLogin : $isLogin');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignScreen()));
    } else {
      print('로그인 상태임 : $isLogin');
      String? accessToken;
      accessToken = await getAccessToken();
      if (accessToken != null) {
        try {
          _commentResponse = await getComment(widget.planeId, 0);
          _commentList = _commentResponse.content;
        } catch (error) {
          print('error : $error');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignScreen()));
        }
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignScreen()));
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('댓글'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: SingleChildScrollView(
              child: Column(
                children: _commentList.map((comment) {
                  return CommentWidget(
                      comment: comment,
                      refreshCommentScreen: () {
                        setState(() {
                          waitAPI();
                        });
                      });
                }).toList(),
              ),
            ),
          ),
          AddCommentWidget(
            planeId: widget.planeId,
            refreshCommentScreen: () {
              setState(() {
                waitAPI();
              });
            },
          ),
        ],
      ),
    );
  }
}
