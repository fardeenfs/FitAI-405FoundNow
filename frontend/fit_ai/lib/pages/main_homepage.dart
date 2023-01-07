import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final _pages = [const HomePage(), LoginPage(), LoginPage(), LoginPage()];
  var currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentindex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setState(() {
                  currentindex = index;
                }),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined), label: 'Plan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.analytics_outlined), label: 'Report'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: 'Settings'),
            ]));
  }
}
