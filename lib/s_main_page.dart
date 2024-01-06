import 'package:flutter/material.dart';

import 'body.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int bottomBarIndex;

  @override
  void initState() {
    bottomBarIndex = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          },
          child: const Text(
            'MapTravel',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green),
          ),
        ),
        surfaceTintColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5), // Divider의 높이
          child: Divider(
            height: 1,
            color: Colors.grey, // Divider 색상
          ),
        ),
      ),
      body: Body(
        bottomBarIndex: bottomBarIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomBarIndex,
        onTap: (newIndex) => setState(() {
          bottomBarIndex = newIndex;
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline,
              ),
              label: 'Write'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
              ),
              label: 'Bookmark'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_sharp,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
