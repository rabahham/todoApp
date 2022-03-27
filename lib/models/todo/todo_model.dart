import 'package:flutter/material.dart';

class TodoModel {
  final int id;
  final String title;
  final String time;
  TodoModel({
    @required this.id,
    @required this.title,
    @required this.time,
  });
}
