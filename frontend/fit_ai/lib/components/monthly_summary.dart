import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import '../datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[300],
        textColor: Colors.grey,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: {
          1: Colors.lightBlue.shade50,
          2: Colors.lightBlue.shade100,
          3: Colors.lightBlue.shade200,
          4: Colors.lightBlue.shade300,
          5: Colors.lightBlue.shade400,
          6: Colors.lightBlue.shade500,
          7: Colors.lightBlue.shade600,
          8: Colors.lightBlue.shade700,
          9: Colors.lightBlue.shade800,
          10: Colors.lightBlue.shade900,
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
