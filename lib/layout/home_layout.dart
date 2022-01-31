import 'dart:async';
import 'dart:math';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:todoApp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoApp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoApp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoApp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:todoApp/shared/components/constants.dart';

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

  initState() {
    print('initState');
    super.initState();

    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[curraentIndex],
        ),
      ),
      body: tasks.length == 0
          ? Center(child: CircularProgressIndicator())
          : screens[curraentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // insertToDatabase();
          if (issBottonSheetShow) {
            if (formKey.currentState.validate()) {
              insertToDatabase(
                titel: tatleController.text,
                date: timeController.text,
                time: dateController.text,
              ).then((value) {
                getDataFromDatabase(database).then((value) {
                  setState(() {
                    tasks = value;
                    print(tasks);
                    issBottonSheetShow = false;
                  });
                  Navigator.pop(context);
                });

                print(' insersu $value ');
              });
            }
          } else {
            scaffoldKey.currentState
                .showBottomSheet(
                  // Ykrina popep
                  (context) => Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
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
                                dateController.text =
                                    DateFormat.yMMMd().format(value);
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
                  elevation: 20.0,
                )
                .closed
                .then((value) {
              issBottonSheetShow = false;
              print('false');
              setState(() {
                fabIcon = Icons.edit;
              });
            });
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

  //  1. create databases
  void createDatabase() async {
    database = await openDatabase(
      'todoapp.db',
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
        getDataFromDatabase(database).then((value) {
          setState(() {
            tasks = value;
            //  print(tasks);
          });
        });
        print(' database opened  ');
      },
    );
  }

  Future insertToDatabase({
    @required titel,
    @required date,
    @required time,
  }) async {
    print('rani hna 9ble');
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title ,date , time ,status) VALUES("$titel"," $time" , "$date","new")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
