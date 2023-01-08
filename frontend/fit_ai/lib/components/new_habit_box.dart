import 'package:flutter/material.dart';

class EnterNewHabitBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const EnterNewHabitBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.hintText,
      required this.onCancel});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlue[100],
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      actions: [
        MaterialButton(
            onPressed: onSave,
            color: Colors.lightBlue[800],
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            )),
        MaterialButton(
            onPressed: onCancel,
            color: Colors.lightBlue[800],
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
