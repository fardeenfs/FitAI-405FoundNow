import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/workout_database.dart';

class AchievemenTile extends StatefulWidget {
  const AchievemenTile({super.key});

  @override
  State<AchievemenTile> createState() => _AchievemenTileState();
}

class _AchievemenTileState extends State<AchievemenTile> {
  final _myBox = Hive.box("WorkoutDb");

  late List<String> arr2 = [];
  @override
  void initState() {
    super.initState();
    workoutDb db = workoutDb();
    db.achievement();
    arr2 = _myBox.get('achievement') ?? ['Error', 'We got an!', 'Error!', '0'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 2,
            child: CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 10.0,
                animation: true,
                percent: double.parse(arr2[3]) / 100,
                circularStrokeCap: CircularStrokeCap.square,
                progressColor: Colors.blue[400]!,
                center: Text(
                  '${arr2[3]}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                )),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(arr2[0],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(arr2[1],
                      style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(arr2[2],
                      style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const Expanded(
              flex: 2, child: Image(image: AssetImage('lib/images/trophy.png')))
        ]),
      ),
    );
  }
}
