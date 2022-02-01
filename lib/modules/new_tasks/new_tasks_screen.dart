import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoApp/shared/components/components.dart';
import 'package:todoApp/shared/components/constants.dart';
import 'package:todoApp/shared/cubit/cubit.dart';
import 'package:todoApp/shared/cubit/state.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).tasks;
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
        });
  }
}
