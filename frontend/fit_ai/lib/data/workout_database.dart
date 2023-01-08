import '../datetime/date_time.dart';
import 'package:http/http.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:math';

final _myBox = Hive.box("WorkoutDb");

// ignore: camel_case_types
class workoutDb {
  final List<List<String>> _arr = [
    ['Pathetic', 'Please move!', 'Work harder', '0'],
    ['Bad', 'On track!', 'Can do better', '25'],
    ['Good', 'In top 50%', 'Keep it up', '50'],
    ['Great', 'In top 15%', 'Doing great!', '75'],
    ['Awesome', "No one like you", 'The God himself', '100']
  ];

  late List<String> arr2 = [];

  List todayWorkoutList = [];
  Map<DateTime, List<int>> heatMapDataSet = {};
  void createDefaultData() {
    // todayWorkoutList[i] = [
    //                        Number of times did an excercise,
    //                        Total mumber of mins spent,
    //                        Total number of calories burned,
    //                        Total number of Steps taken]
    todayWorkoutList = [
      [12, 35, 412, 0],
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  void achievement() {
    // get new achievement if it's a new day OR if there is no achievement
    if (_myBox.get(todaysDateFormatted()) == null ||
        _myBox.get('achievement') == null) {
      final random = Random();
      arr2 = _arr[random.nextInt(_arr.length)];
      _myBox.put('achievement', arr2);
    } else {
      print('no new achievement AS date not changed');
    }
  }

  // load data if it already exists
  void loadData() {
    // if it's a new day, get habit list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
      todayWorkoutList = _myBox.get("CURRENT_WORKOUT_LIST");

      // set all habit completed to false since it's a new day
      for (int i = 0; i < todayWorkoutList.length; i++) {
        todayWorkoutList[i][0] = 0;
        todayWorkoutList[i][1] = 0;
        todayWorkoutList[i][2] = 0;
        todayWorkoutList[i][3] = 0;
      }
    }
    // if it's not a new day, load todays list
    else {
      print('workout_db.dart: ${_myBox.get('Authorization')}');
      todayWorkoutList = _myBox.get(todaysDateFormatted());
    }
  }

  // update database
  void updateDatabase() {
    // update todays entry
    _myBox.put(todaysDateFormatted(), todayWorkoutList);

    // update universal habit list in case it changed (new habit, edit habit, delete habit)
    _myBox.put("CURRENT_WORKOUT_LIST", todayWorkoutList);
  }
}
