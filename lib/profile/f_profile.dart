import 'package:flutter/material.dart';
import 'package:maptravel/common/constant/profile_constant.dart';

import '../vo/dummy.dart';
import '../vo/vo_user.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<ProfileFragment> {
  late User _user;

  @override
  void initState() {
    _user = user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius:
                    BorderRadius.circular(ProfileConstant.profileImageRadius),
              ),
              child: Image.network(
                _user.profileImageUrl,
                width: ProfileConstant.profileImageWidth,
                height: ProfileConstant.profileImageHeight,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey.shade200),
              bottom: BorderSide(color: Colors.grey.shade200),
            )),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내 정보',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
