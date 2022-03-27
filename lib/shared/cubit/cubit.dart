import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoApp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoApp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoApp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoApp/shared/cubit/state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int curraentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(index) {
    curraentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archavedtasks = [];

  //  1. create databases
  void createDatabase() {
    openDatabase(
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
        getDataFromDatabase(database);
        print(' database opened  ');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required titel,
    @required date,
    @required time,
  }) async {
    // print('rani hna 9ble');
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title ,time , date  ,status) VALUES("$titel"," $time" , "$date","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return null;
    });
  }

  void upDateFromDatabase({
    @required String status,
    @required int id,
  }) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id= ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpDateDatabaseState());
    });
  }

  void deletFromDatabase({
    @required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id= ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(DeletDataBaseState());
    });
  }

  void getDataFromDatabase(database) {
    newtasks = [];
    donetasks = [];
    archavedtasks = [];
    emit(AppGetLougingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          archavedtasks.add(element);
        }
      });

      emit(AppGetbaseState());
    });
  }

  bool issBottonSheetShow = false;
  IconData fabIcon = Icons.edit;

  void ChengeissBottonSheetShow(@required bool issBottonSheetShowValidet) {
    issBottonSheetShow = issBottonSheetShowValidet;
    emit(ChengeissBottonSheetShowState());
  }

  void ChengefabIconState(@required icon) {
    fabIcon = icon;
    emit(ChengeissBottonSheetShowState());
  }
}
