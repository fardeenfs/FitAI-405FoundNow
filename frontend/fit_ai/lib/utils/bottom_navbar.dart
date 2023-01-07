import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../globals.dart' as globals;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _pages = [const HomePage(), LoginPage(), LoginPage(), LoginPage()];
  void navigateToPage(int index) {
    setState(() {
      // access the current index from the parent widget
      globals.currentIndex = index;
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => _pages[globals.currentIndex]));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: globals.currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => navigateToPage(index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Plan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), label: 'Report'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ]);
  }
}
