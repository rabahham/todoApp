import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoApp/shared/components/components.dart';

import 'package:todoApp/shared/cubit/cubit.dart';
import 'package:todoApp/shared/cubit/state.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).archavedtasks;
          return BuiledNoTasks(tasks: tasks);
        });
  }
}
