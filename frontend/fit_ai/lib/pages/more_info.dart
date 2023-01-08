import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../pages/main_homepage.dart';

class MoreInfo extends StatefulWidget {
  const MoreInfo({super.key});

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  final _myBox = Hive.box("WorkoutDb");
  final nameController = TextEditingController();
  final birthdayController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final passwordController = TextEditingController();
  void login(String name, String birthday, String height, String weight) async {
    Map data = {
      'name': name,
      'birthday': birthday,
      'height': height,
      'weight': weight
    };

    String body = json.encode(data);

    Response response = await post(
      Uri.parse('https://hacked2023.herokuapp.com/users/user-profile/'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": _myBox.get('Authorization')
      },
      body: body,
    );
    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MainHomePage(
                    index: 0,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: ListView(children: [
          Column(children: [
            const SizedBox(height: 50),
            const Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name'),
                )),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: birthdayController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'birthday',
                      hintText: 'Enter your birthday YYYY-MM-DD'),
                )),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: heightController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Height',
                      hintText: 'Enter your Height in meters'),
                )),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: weightController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Weight',
                      hintText: 'Enter your Weight in kilograms'),
                )),
            const SizedBox(height: 20),
            MaterialButton(
                onPressed: () => login(
                    nameController.text,
                    birthdayController.text,
                    heightController.text,
                    weightController.text),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text('Complete Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))))),
            const SizedBox(height: 20),
            const Text('Please sign up and then login if you are a new user!'),
          ])
        ])));
  }
}
