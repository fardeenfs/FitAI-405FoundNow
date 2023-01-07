import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final String name;
  final String greeting;
  final String image;
  const ProfileSection(
      {super.key,
      required this.name,
      required this.greeting,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(image))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(greeting,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(name,
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
