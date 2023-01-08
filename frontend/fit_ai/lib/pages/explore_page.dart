import 'package:fit_ai/utils/profile.dart';
import 'package:flutter/material.dart';
import '../utils/excercise_card.dart';
import '../utils/camera_plugin.dart';
import '../data/workout_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  workoutDb db = workoutDb();
  final _myBox = Hive.box("WorkoutDb");
  @override
  void initState() {
    if (_myBox.get('CURRENT_WORKOUT_LIST') == null) {
      db.createDefaultData();
    } else {
      db.loadData();
      print('loaded data ${db.todayWorkoutList}');
    }
    db.updateDatabase();
    super.initState();
  }

  void modelOpen(String id, String path, String imagePath, String textbody) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraPlugin(
                id: id, path: path, imagepath: imagePath, textBody: textbody)));
  }

  String greeting() {
    if (DateTime.now().hour > 12) {
      return 'Good Afternoon!';
    } else if (DateTime.now().hour > 17) {
      return 'Good Evening!';
    } else {
      return 'Good Morning!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSection(
                    name: 'Shelly Marsh',
                    greeting: greeting(),
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
                          onpressed: (() => modelOpen(
                              'Dips',
                              'assets/dips.html',
                              'lib/images/dips.gif',
                              'Tricep dips: Sit on a bench/couch, hands on furniture, straighten arms and bend elbows. Support body weight in arms. One set is 12 reps.')),
                          image: 'lib/images/dips.gif'),
                      const SizedBox(width: 25),
                      ExcerciseCard(
                          onpressed: (() => modelOpen(
                              'Push ups',
                              'assets/pushup.html',
                              'lib/images/push_up.gif',
                              'Push-ups: Start on hands and knees, straighten legs and keep body in straight line. Bend elbows to lower chest to mat. One set is 12 reps.')),
                          image: 'lib/images/push_up.gif'),
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
                          onpressed: (() => modelOpen(
                              'Lunges',
                              'assets/lunges.html',
                              'lib/images/lunges.gif',
                              "Lunge: Step right foot behind, lower hips, bend knees to 90 degrees, don't shift left knee past left foot. Press left heel into floor, bring right leg forward. 10 reps per leg is one set.")),
                          image: 'lib/images/lunges.gif'),
                      const SizedBox(width: 25),
                      ExcerciseCard(
                          onpressed: (() => modelOpen(
                              'Squats',
                              'assets/squats.html',
                              'lib/images/squats.gif',
                              'Squat jumps: Stand with feet shoulder-width apart, hinge hips and bend knees to squat. Jump straight up and land softly, immediately squat again. One set is 10 reps.')),
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
