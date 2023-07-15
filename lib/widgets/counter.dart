// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CounterTasks extends StatelessWidget {
  final int? completedTasks;
  final int? tasksCount;
  final bool? allDone;
  const CounterTasks(
      {super.key,
      required this.completedTasks,
      required this.tasksCount,
      required this.allDone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(11),
      child: Text(
        (tasksCount == 0 && completedTasks == 0)
            ? "No tasks found"
            : "$completedTasks / $tasksCount",
        style: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.bold,
          color: completedTasks == tasksCount
              ? Color.fromARGB(255, 142, 253, 200)
              : Colors.white,
        ),
      ),
    );
  }
}
