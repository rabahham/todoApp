import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:todoApp/shared/cubit/cubit.dart';
import 'package:todoApp/shared/cubit/state.dart';

//  1. create databases
//  2. create tables
//  3.  open database
//  4. insert to database
//  5. get from database
//  6. update in datbase
//  7. delete from database
class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var tatleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..createDatabase(), // as if you ceriate variable and seved in var and cell it and use
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.curraentIndex],
              ),
            ),
            body: state is! AppGetLougingState
                ? cubit.screens[cubit.curraentIndex]
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.issBottonSheetShow) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        titel: tatleController.text,
                        date: dateController.text,
                        time: timeController.text);
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
                    cubit.ChengeissBottonSheetShow(false);

                    cubit.ChengefabIconState(Icons.edit);
                  });
                  cubit.ChengeissBottonSheetShow(true);
                  cubit.ChengefabIconState(Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.curraentIndex,
              onTap: (index) {
                cubit.ChangeIndex(index);
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
        },
      ),
    );
  }
}
