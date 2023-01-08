import 'package:flutter/material.dart';
import '../components/monthly_summary.dart';
import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/new_habit_box.dart';
import '../data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabbitPage extends StatefulWidget {
  const HabbitPage({super.key});

  @override
  State<HabbitPage> createState() => _HabbitPageState();
}

class _HabbitPageState extends State<HabbitPage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box('HabitPagedb');
  @override
  void initState() {
    if (_myBox.get('CURRENT_HABIT_LIST') == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
    super.initState();
  }

  bool habitCompleted = false;
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todayHabitList[index][1] = value!;
      if (value == true) {
        db.todayHabitList[index][2] = Colors.lightBlue.shade400.value;
      } else {
        db.todayHabitList[index][2] = Colors.lightBlue.shade50.value;
      }
    });
    db.updateDatabase();
  }

  final _newHabitController = TextEditingController();

  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewHabitBox(
            controller: _newHabitController,
            onCancel: cancelNewHabit,
            hintText: db.todayHabitList[index][0],
            onSave: () => editNewHabit(index),
          );
        });
  }

  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewHabitBox(
            controller: _newHabitController,
            onCancel: cancelNewHabit,
            hintText: "Enter new habit",
            onSave: saveNewHabit,
          );
        });
  }

  void saveNewHabit() {
    setState(() {
      db.todayHabitList.add(
          [_newHabitController.text, false, Colors.lightBlue.shade50.value]);
    });
    db.updateDatabase();
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void editNewHabit(int index) {
    setState(() {
      db.todayHabitList[index][0] = _newHabitController.text;
    });
    db.updateDatabase();
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void cancelNewHabit() {
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: MyFloatingActionButton(
          onPressed: createNewHabit,
        ),
        body: ListView(
          children: [
            MonthlySummary(
              datasets: db.heatMapDataSet,
              startDate: _myBox.get("START_DATE"),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todayHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: db.todayHabitList[index][0],
                  habitCompleted: db.todayHabitList[index][1],
                  backgroundColor: Color(db.todayHabitList[index][2]),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => deleteHabit(index),
                  onChanged: (value) => checkBoxTapped(value, index),
                );
              },
            )
          ],
        ));
  }
}
