import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/habit_page.dart';
import '../pages/report_page.dart';
import '../pages/explore_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainHomePage extends StatefulWidget {
  final int index;
  const MainHomePage({super.key, required this.index});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final _myBox = Hive.box("WorkoutDb");
  final _pages = [
    HomePage(),
    const HabbitPage(),
    const ReportPage(),
    const ExplorePage(),
  ];
  int currentindex = 0;
  void initState() {
    super.initState();
    currentindex = widget.index;
  }

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
                  icon: Icon(Icons.fitness_center_outlined), label: 'Explore'),
            ]));
  }
}
