import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileSection extends StatefulWidget {
  final String name;
  final String greeting;
  final String image;
  ProfileSection(
      {super.key,
      required this.name,
      required this.greeting,
      required this.image});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final _myBox = Hive.box("WorkoutDb");

  void checkUser() async {
    Response response2 = await get(
      Uri.parse('https://hacked2023.herokuapp.com/users/user-profile/'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": _myBox.get('Authorization')
      },
    );

    if (response2.statusCode != 200 || _myBox.get('Authorization') == null) {
      print('profile.dart: User logged in successfully.');
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(widget.image))),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(widget.greeting,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(widget.name,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
