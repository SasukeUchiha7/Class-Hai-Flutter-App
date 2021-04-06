import 'package:class_hai/models/user_model.dart';
import 'package:class_hai/screens/subject/subject_profile.dart';
import 'package:class_hai/screens/wrapper.dart';
import 'package:class_hai/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserId>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/subject': (context) => SubjectProfile(),
        },
      ),
    );
  }
}
