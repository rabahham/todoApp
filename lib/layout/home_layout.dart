import 'dart:async';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:todoApp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoApp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoApp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoApp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  //  1. create databases
  //  2. create tables
  //  3.  open database
  //  4. insert to database
  //  5. get from database
  //  6. update in datbase
  //  7. delete from database

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  Database database;
  var scaffoldKey =
      GlobalKey<ScaffoldState>(); // bcche na2rfo ta3mn win rana dayrino
  var formKey = GlobalKey<FormState>();
  bool issBottonSheetShow = false;
  IconData fabIcon = Icons.edit;
  var tatleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  void initSatate() {
    super.initState();

    createDatabase();
  }

  int curraentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[curraentIndex],
        ),
      ),
      body: screens[curraentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // insertToDatabase();
          if (issBottonSheetShow) {
            if (formKey.currentState.validate()) {
              Navigator.pop(
                  context); // neghle9 biha navigator wla popop wla bottomSeet
              issBottonSheetShow = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            }
          } else {
            scaffoldKey.currentState.showBottomSheet(
              // Ykrina popep
              (context) => Container(
                padding: EdgeInsets.all(15),
                color: Colors.grey[100],
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultFornField(
                        NameController: tatleController,
                        text: 'Title',
                        iconText: Icons.title,
                        onTap: () {},
                      ),
                      defaultFornField(
                        NameController: timeController,
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            timeController.text =
                                value.format(context).toString();
                          });
                        },
                        text: 'Time',
                        iconText: Icons.watch_later_outlined,
                        keyboardType: TextInputType.datetime,
                      ),
                      defaultFornField(
                        NameController: dateController,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2022-05-26'),
                          ).then((value) {
                            print(DateFormat.MMMMd().format(value));
                          });
                        },
                        text: 'Date',
                        iconText: Icons.calendar_today_rounded,
                        keyboardType: TextInputType.datetime,
                      ),
                    ],
                  ),
                ),
              ),
            );
            issBottonSheetShow = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: curraentIndex,
        onTap: (index) {
          setState(() {
            curraentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database create ');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created ');
        }).catchError((error) {
          print('Error when Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print(' database opened  ');
      },
    );
  }

  void insertToDatabase() {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSRET INTO tasks (titele,date , time ,status) VALUES("first tasks"," 8222" , "591","arw")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return null;
    });
  }
}