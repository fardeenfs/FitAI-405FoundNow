import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final Function(bool?)? onChanged;
  final bool habitCompleted;
  final Function(BuildContext)? settingsTapped;
  final Color? backgroundColor;
  final Function(BuildContext)? deleteTapped;
  const HabitTile(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      required this.onChanged,
      required this.settingsTapped,
      required this.backgroundColor,
      required this.deleteTapped});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: Colors.lightBlue.shade500,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade500,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              // Checkbox
              Expanded(
                flex: 0,
                child: Checkbox(
                  value: habitCompleted,
                  onChanged: onChanged,
                ),
              ),
              Expanded(flex: 6, child: Text(habitName)),
              Expanded(flex: 1, child: Icon(Icons.arrow_back)),
            ],
          ),
        ),
      ),
    );
  }
}
