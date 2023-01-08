import 'package:fit_ai/utils/profile.dart';
import 'package:flutter/material.dart';
import '../utils/excercise_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileSection(
                    name: 'Shelly Marsh',
                    greeting: 'Good Morning!',
                    image: 'lib/images/profile.png'),
                const SizedBox(height: 20),
                const Text('UpperBody Excercises',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ExcerciseCard(
                          onpressed: (() => print('pressed')),
                          image: 'lib/images/dips.gif'),
                      const SizedBox(width: 25),
                      ExcerciseCard(
                          onpressed: (() => print('pressed')),
                          image: 'lib/images/planks.gif'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('LowerBody Excercises',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ExcerciseCard(
                          onpressed: (() => print('pressed')),
                          image: 'lib/images/lunges.gif'),
                      const SizedBox(width: 25),
                      ExcerciseCard(
                          onpressed: (() => print('pressed')),
                          image: 'lib/images/squats.gif'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
