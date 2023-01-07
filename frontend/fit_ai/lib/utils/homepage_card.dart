import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title1;
  final String title2;
  final String subtitle;
  final String image;
  const HomeCard(
      {super.key,
      required this.title1,
      required this.title2,
      required this.subtitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title1,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(title2,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(subtitle,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey))
                  ],
                ),
                Image.asset(
                  image,
                  width: 100,
                  height: 250,
                )
              ],
            ),
          )),
    );
  }
}
