import './teachable.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/workout_database.dart';

class CameraPlugin extends StatefulWidget {
  final String id, path, imagepath, textBody;
  CameraPlugin(
      {super.key,
      required this.textBody,
      required this.id,
      required this.path,
      required this.imagepath});

  @override
  State<CameraPlugin> createState() => _CameraPluginState();
}

class _CameraPluginState extends State<CameraPlugin> {
  late Stopwatch _stopwatch;
  final workoutDb db = workoutDb();

  final _myBox = Hive.box("WorkoutDb");
  void initialise() {
    _stopwatch = Stopwatch();
    _stopwatch.start();
    if (_myBox.get('CURRENT_WORKOUT_LIST') == null) {
      db.createDefaultData();
    } else {
      db.loadData();
      print('camera_plugin.dart : loaded data ${db.todayWorkoutList}');
    }
  }

  void addReps(String pose) {
    if (double.parse(pose) != null) {
      setState(() {
        db.todayWorkoutList[0][0] +=
            double.parse(pose); // incrementing the REPS of workouts
        db.todayWorkoutList[0][2] +=
            ((double.parse(pose) * 8 * 68) / 20) * 0.175;
        db.todayWorkoutList[0][3] = 0;
        db.updateDatabase();
      });
    }
  }

  @override
  void dispose() {
    _stopwatch.stop();
    Duration elapsedTime = _stopwatch.elapsed;
    int elapsedSeconds = elapsedTime.inMinutes;
    db.todayWorkoutList[0][1] += elapsedSeconds;
    db.updateDatabase();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  String pose = "0";
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar takes id from the home page
        appBar: AppBar(
          title: Text(widget.id),
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 400,
                        child: Column(children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Teachable(
                                path: widget.path,
                                results: (res) {
                                  var resp = res;
                                  setState(() {
                                    if (isNumeric(resp)) {
                                      pose = resp;
                                      addReps(pose);
                                    } else {
                                      pose = pose;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 230,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: AssetImage(widget.imagepath),
                                  ),
                                ))),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Rep Count:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              pose,
                              style: TextStyle(
                                color:
                                    pose == "error" ? Colors.red : Colors.green,
                                fontSize: 60,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Flexible(
                      child: Text(
                        widget.textBody,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
