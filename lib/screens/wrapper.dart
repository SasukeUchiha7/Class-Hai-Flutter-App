import 'package:class_hai/models/user_model.dart';
import 'package:class_hai/screens/auth/authorize.dart';
import 'package:class_hai/screens/home/home.dart';
import 'package:class_hai/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // provider for user auth since available by StreamProvider
    final user = Provider.of<UserId>(context);
    if (user == null) {
      return Authenticate();
    } else {
      // print(version);
      return StreamProvider<UserData>.value(
          value: DatabaseService(uid: user.uid).userData, child: Home());
    }
  }
}
