//import 'package:app2/modules/test/app1scaffold.dart';
//import 'package:app2/test.dart';
import 'package:todoApp/layout/home_layout.dart';
import 'package:todoApp/modules/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:todoApp/modules/ripretoir/listDataFromRipretoir.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "flutter App",
      theme: ThemeData(
          // primarySwatch: Colors.green,
          ),
      //   home: DataListDaFromRipretoir(),
      // home: login_screen(),
      home: HomeLayout(),
    );
  }
}
