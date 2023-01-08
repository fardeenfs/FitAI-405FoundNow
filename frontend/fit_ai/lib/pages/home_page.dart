import '../utils/bottom_card.dart';
import '../utils/homepage_card.dart';
import '../utils/profile.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(children: [
              const ProfileSection(
                  name: 'Shelly Marsh',
                  greeting: 'Good Morning!',
                  image: 'lib/images/profile.png'),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: const [
                    HomeCard(
                        title1: 'Set Your',
                        title2: 'Workout Plan',
                        subtitle: 'Training & Nutrition',
                        image: 'lib/images/bottle.png'),
                    HomeCard(
                        title1: 'Set Your',
                        title2: 'Workout Plan',
                        subtitle: 'Training & Nutrition',
                        image: 'lib/images/treadmill.png'),
                    HomeCard(
                        title1: 'Set Your',
                        title2: 'Workout Plan',
                        subtitle: 'Training & Nutrition',
                        image: 'lib/images/dumbbell.png')
                  ],
                ),
              ),
              SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Colors.lightBlue)),
              BottomCard()
            ]),
          )
        ],
      )),
    );
  }
}
