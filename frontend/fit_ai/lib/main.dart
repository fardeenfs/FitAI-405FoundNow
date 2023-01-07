import 'package:fit_ai/pages/home_page.dart';
import 'package:fit_ai/pages/login_page.dart';
import 'package:fit_ai/pages/main_homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MainHomePage());
  }
}
