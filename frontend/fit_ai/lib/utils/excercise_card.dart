import 'package:flutter/material.dart';

class ExcerciseCard extends StatelessWidget {
  final String image;
  final VoidCallback onpressed;
  const ExcerciseCard(
      {super.key, required this.image, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // ONPRESS CONTROLL  NAV BAR PROGRAMMATICALLY TO INDEX 1
      padding: EdgeInsets.zero,
      onPressed: onpressed,
      child: Container(
          width: 240,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage(image),
                ),
              ))),
    );
  }
}
