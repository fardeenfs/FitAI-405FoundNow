import 'package:fit_ai/data/workout_database.dart';
import 'package:fit_ai/utils/achievement_tile.dart';
import 'package:fit_ai/utils/report_tile.dart';
import 'package:flutter/material.dart';
import '../utils/profile.dart';
import '../datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:convert';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _myBox = Hive.box("WorkoutDb");
  workoutDb db = workoutDb();
  final List<String> past7DaysList = past7Days();
  final List<String> _months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<int> past7 = past7Dates();
  final List<double> prevarr = [412, 325, 300, 322, 500, 842];

  int _selectedIndex = 6; // add this line
  late List<int> arr = [];
  void setReporttile(int index) {
    const List<List<int>> arr2 = [
      [7, 35, 412, 0],
      [18, 45, 325, 0],
      [13, 24, 300, 0],
      [22, 32, 322, 0],
      [25, 29, 500, 0],
      [38, 35, 842, 0],
    ];

    if (index == 6 && _myBox.get('CURRENT_WORKOUT_LIST') != null) {
      db.loadData();
      arr = db.todayWorkoutList[0];
      print('report_page.dart: ${arr}');
    } else {
      // FETCH FROM API HERE
      arr = arr2[index];
    }
  }

  // void auth() async {
  //   Response response = await get(
  //     Uri.parse('http://hacked2023.herokuapp.com/workout/activity/'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": _myBox.get('Authorization')
  //     },
  //   );

  //   prevarr = jsonDecode(response.body);
  // }

  @override
  void initState() {
    _myBox.put("Authorization",
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjc0MDQ2NDA5LCJpYXQiOjE2NzMxODI0MDksImp0aSI6IjE5NDYyN2NhMzFkMjQzMWNiNGM3MTlmZWI4ZTA3NDEzIiwidXNlcl9pZCI6MzB9.kooip_-1tjhSSd1_LlfNhvDBEKK_52FFBrxQ8wiXgqE");
    print(_myBox.get('Authorization'));
    super.initState();
    // auth();

    if (_myBox.get('CURRENT_WORKOUT_LIST') != null) {
      db.loadData();
      arr = db.todayWorkoutList[0];
    }
  }

  final List<SalesData> chartData = [
    SalesData(DateTime(2010, 1, 2), 412),
    SalesData(DateTime(2010, 1, 3), 325),
    SalesData(DateTime(2010, 1, 4), 300),
    SalesData(DateTime(2010, 1, 5), 322),
    SalesData(DateTime(2010, 1, 6), 500),
    SalesData(DateTime(2010, 1, 7), 842),
  ];

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
                      name:
                          'Today ${DateTime.now().day} ${_months[DateTime.now().month]}',
                      // get current date and month (month in string)

                      greeting: 'Report',
                      image: 'lib/images/profile.png'),
                  const SizedBox(height: 20),
                  // PAST 7 DAYS BUTTONS
                  Container(
                    height: 80,
                    child: ListView.builder(
                      itemCount: past7.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return MaterialButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                              setReporttile(_selectedIndex);
                            });
                          },
                          child: Container(
                              width: 70,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[200]!, width: 1),
                                color: _selectedIndex == index
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(past7DaysList[index],
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  Text('${past7[index]}',
                                      style: TextStyle(
                                          color: _selectedIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Achievements tile
                  const AchievemenTile(),
                  const SizedBox(height: 20),
                  // 3 tiles for number of excercises, calories burned and time spent
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReportTile(
                        imagePath: 'lib/icons/flexed biceps.png',
                        color: Colors.lightBlue.shade50,
                        number: '${arr[0]}',
                        text: 'Exercises',
                      ),
                      ReportTile(
                        imagePath: 'lib/icons/fire.png',
                        color: Colors.red.shade50,
                        number: '${arr[2]}',
                        text: 'Calories',
                      ),
                      ReportTile(
                        imagePath: 'lib/icons/stopwatch.png',
                        color: Colors.green.shade50,
                        number: '${arr[1]}',
                        text: 'Minutes',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Graph for calories burned
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Activites',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Weekly',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                  Container(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SfCartesianChart(
                          primaryXAxis: DateTimeAxis(),
                          series: <ChartSeries>[
                            // Renders line chart
                            LineSeries<SalesData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) => sales.day,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales)
                          ]),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.day, this.sales);
  final DateTime day;
  final double sales;
}
