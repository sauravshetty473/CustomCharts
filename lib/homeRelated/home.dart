import 'package:flutter/material.dart';

import 'home_page.dart';
import 'my_collections.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  PageController _pageController;

  void onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
    _pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: onPageChanged,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.file_present),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder), label: 'My Collections'),
          ],
        ),
        backgroundColor: Colors.white,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            HomePage(),
            MyCollections(),
          ],
        ));
  }
}
