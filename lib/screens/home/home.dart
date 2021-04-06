import 'package:class_hai/models/class_model.dart';
import 'package:class_hai/models/user_model.dart';
import 'package:class_hai/screens/home/class_list.dart';
import 'package:class_hai/screens/home/nav_drawer.dart';
import 'package:class_hai/services/auth.dart';
import 'package:class_hai/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  //auth
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    //userdata provider
    final userData = Provider.of<UserData>(context);
    final String name = userData.name ?? 'User';
    return StreamProvider<List<ClassData>>.value(
      value: DatabaseService().classes,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan[900],
          elevation: 0.0,
          title: Text(
            'Class Hai ?',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Center(
                child: Text(
              'Hi, $name',
              style: TextStyle(fontSize: 16, fontFamily: 'QuickSand'),
            )),
            SizedBox(
              width: 10,
            ),
            // IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await _auth.logOut();
                }),
          ],
        ),
        drawer: NavDrawer(),
        body: ClassList(username: name),
      ),
    );
  }
}
