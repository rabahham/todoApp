import 'package:flutter/material.dart';
import 'package:todoApp/shared/components/components.dart';
import 'package:todoApp/shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => defuletItem(
            time: tasks[index]['time'],
            title: tasks[index]['title'],
            date: tasks[index]['date']),
        separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
        itemCount: tasks.length);
  }
}
