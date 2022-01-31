import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color bacGrondcolor = Colors.blue,
  bool isUpperCase = true, // kibheb text  smell
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
  @required title,
  @required time,
  @required date,
}) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 12, 20, 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text(
              time,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
