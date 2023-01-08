import 'package:fit_ai/pages/main_homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('HabitPagedb');
  await Hive.openBox('WorkoutDb');

  await Permission.camera.request();
  await Permission.microphone.request();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  var currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainHomePage(
          index: 0,
        ));
  }
}
