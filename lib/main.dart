import 'package:bloc/bloc.dart';
import 'package:todoApp/layout/home_layout.dart';

import 'package:flutter/material.dart';

import 'package:todoApp/modules/ripretoir/listDataFromRipretoir.dart';
import 'package:todoApp/shared/bloc_observer.dart';
import 'package:todoApp/shared/cubit/cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo flutter App",
      home: HomeLayout(),
    );
  }
}
