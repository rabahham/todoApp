import 'package:todoApp/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataListDaFromRipretoir extends StatelessWidget {
  List<UserModel> Users = [
    UserModel(
      id: 1,
      Name: 'rabah hammani',
      Phone: '+21356545854',
    ),
    UserModel(
      id: 2,
      Name: 'Moh te9ile ',
      Phone: '+212564552125',
    ),
    UserModel(
      id: 3,
      Name: 'Ticous Sahbi',
      Phone: '+21325653225',
    ),
    UserModel(
      id: 4,
      Name: 'mohemd mo9rai',
      Phone: '+21312546475',
    ),
    UserModel(
      id: 5,
      Name: 'Djamale Macou',
      Phone: '+21455466265',
    ),
    UserModel(
      id: 6,
      Name: 'Kche Wahede',
      Phone: '+21325653215',
    ),
    UserModel(
      id: 1,
      Name: 'rabah hammani',
      Phone: '+21356545854',
    ),
    UserModel(
      id: 2,
      Name: 'Moh te9ile ',
      Phone: '+212564552125',
    ),
    UserModel(
      id: 3,
      Name: 'Ticous Sahbi',
      Phone: '+21325653225',
    ),
    UserModel(
      id: 4,
      Name: 'mohemd mo9rai',
      Phone: '+21312546475',
    ),
    UserModel(
      id: 5,
      Name: 'Djamale Macou',
      Phone: '+21455466265',
    ),
    UserModel(
      id: 6,
      Name: 'Kche Wahede',
      Phone: '+21325653215',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ripertoir '),
      ),
      body: ListView.separated(
        itemCount: Users.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return buildItmes(Users[index]);
        },
      ),
    );
  }

  // build list
  // build itms
  // add itmes to list

  Widget buildItmes(UserModel user) => Container(
        margin: EdgeInsetsDirectional.only(end: 10.0, start: 10.0),
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              // margin: 10.0,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 25.0,
                child: Text('${user.id}',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.Name}',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                ),
                // SizedBox(
                //   height: 2.0,
                // ),
                Text(
                  '${user.Phone}',
                  style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                  maxLines: 1,
                )
              ],
            ),
          ],
        ),
      );
}
