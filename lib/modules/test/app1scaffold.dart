import 'package:todoApp/modules/test/test.dart';
import 'package:flutter/material.dart';

class app1Scaffold extends StatelessWidget {
  TextStyle s = TextStyle(
    color: Colors.white,
    fontSize: 35,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.yellowAccent,
        title: Text(
          "AppBar Title ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        color: Colors.redAccent,
        // height: double.infinity, // container ywli ydi kale chacha

        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText("aaa", s),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.all(8.0), child: MyText("rabah", s))),
          ],
        ),
      ),
    );
  }
}
