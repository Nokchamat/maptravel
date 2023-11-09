import 'package:flutter/material.dart';
import 'package:maptravel/home/s_home.dart';
import 'package:maptravel/profile/s_profile.dart';
import 'package:maptravel/write/s_write.dart';

import 'bookmark/s_bookmark.dart';

class Body extends StatelessWidget {
  final int bottomBarIndex;

  const Body({required this.bottomBarIndex, super.key});

  @override
  Widget build(BuildContext context) {
    switch (bottomBarIndex) {
      case 1:
        return const WriteScreen();
      case 2:
        return const BookmarkScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }
}
