import 'package:flutter/material.dart';
import 'package:maptravel/home/f_home.dart';
import 'package:maptravel/profile/f_profile.dart';
import 'package:maptravel/write/f_write.dart';

import 'bookmark/f_bookmark.dart';

class Body extends StatelessWidget {
  final int bottomBarIndex;

  const Body({this.bottomBarIndex = 1, super.key});

  @override
  Widget build(BuildContext context) {
    switch (bottomBarIndex) {
      case 1:
        return const WriteFragment();
      case 2:
        return const BookmarkFragment();
      case 3:
        return const ProfileFragment();
      default:
        return const HomeFragment();
    }
  }
}
