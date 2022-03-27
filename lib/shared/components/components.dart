import 'package:flutter/material.dart';
import 'package:todoApp/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color bacGrondcolor = Colors.blue,
  bool isUpperCase = true, //  text  smellkeys
  double raduis = 10.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toLowerCase() : text,
            style: TextStyle(color: Colors.white)),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: bacGrondcolor,
      ),
    );

Widget defaultFornField({
  @required var NameController,
  double margin = 10.0,
  @required String text,
  double hintStylefontSise = 20.0,
  double labelStylefontSize = 30.0,
  @required Function onTap,
  @required IconData iconText,
  TextInputType keyboardType = TextInputType.text,
}) =>
    Container(
      margin: EdgeInsets.all(margin),
      child: TextFormField(
        controller: NameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "$text",
            labelStyle: TextStyle(fontSize: labelStylefontSize),
            hintText: "Enter $text",
            hintStyle: TextStyle(fontSize: hintStylefontSise),
            prefixIcon: Icon(iconText)),
        keyboardType: keyboardType,
        onTap: onTap,
        validator: (value) {
          if (value.isEmpty) {
            return 'password must not be empty';
          }
          return null;
        },
      ),
    );

Widget defuletItem({
  @required Map model,
  context,
}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      background: Container(
        color: Colors.red[400],
        child: Center(
          child: Text(
            'Remove',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 12, 20, 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              color: Colors.green,
              onPressed: () {
                AppCubit.get(context)
                    .upDateFromDatabase(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.check_box,
              ),
            ),
            IconButton(
              color: Colors.grey,
              onPressed: () {
                AppCubit.get(context)
                    .upDateFromDatabase(status: 'arcaved', id: model['id']);
              },
              icon: Icon(
                Icons.archive,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (diriction) {
        AppCubit.get(context).deletFromDatabase(
          id: model['id'],
        );
      },
    );

Widget BuiledNoTasks({@required List<Map> tasks}) => tasks.length > 0
    ? ListView.separated(
        itemBuilder: (context, index) =>
            defuletItem(model: tasks[index], context: context),
        separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
        itemCount: tasks.length)
    : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, please Add Some Tasks',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
