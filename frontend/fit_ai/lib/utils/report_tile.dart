import 'package:flutter/material.dart';

class ReportTile extends StatefulWidget {
  final String imagePath;
  final Color color;
  final String number;
  final String text;

  const ReportTile(
      {super.key,
      required this.imagePath,
      required this.color,
      required this.number,
      required this.text});

  @override
  State<ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 100,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            widget.imagePath,
            height: 40,
            width: 40,
          ),
          const SizedBox(height: 10),
          Text(
            widget.number,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ]),
      ),
    );
  }
}
