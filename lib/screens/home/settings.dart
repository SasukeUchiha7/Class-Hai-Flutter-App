import 'package:class_hai/models/class_model.dart';
import 'package:class_hai/services/database.dart';
import 'package:class_hai/shared/constants.dart';
import 'package:class_hai/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingForm extends StatefulWidget {
  //to pass value from classtile
  final ClassData cls;
  final String username;
  SettingForm({this.cls, this.username});

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  //form states
  bool isClass = false;
  String classLink = '';

  // String updatedBy = '';

  @override
  Widget build(BuildContext context) {
    //for user name
    //print(widget.cls.cid)
    return StreamBuilder<ClassData>(
      stream: DatabaseService(cid: widget.cls.cid).cls,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // ClassData cData = snapshot.data;
          return Form(
            child: Column(
              children: [
                Text(widget.cls.className,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30,
                ),
                SwitchListTile(
                  title: Text('Is there a class today ?'),
                  activeColor: Colors.cyan[900],
                  value: isClass,
                  onChanged: (val) => setState(() => isClass = val),
                ),
                SizedBox(height: 20),
                TextFormField(
                  enabled: isClass ? true : false,
                  initialValue: widget.cls.classLink,
                  decoration: inputTextDecoration.copyWith(
                      hintText: 'Enter the url for the class'),
                  onChanged: (val) => setState(() {
                    if (isClass)
                      classLink = val;
                    else
                      classLink = 'hi';
                  }),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.cyan[900],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.cyan[900],
                      onPressed: () async {
                        Timestamp updatedAt =
                            Timestamp.fromMillisecondsSinceEpoch(
                                DateTime.now().millisecondsSinceEpoch);
                        print('$classLink ----- ${widget.cls.classLink}');
                        await DatabaseService(cid: widget.cls.cid)
                            .updateClassData(
                                widget.cls.className,
                                isClass,
                                classLink==''? widget.cls.classLink: classLink,
                                updatedAt,
                                widget.username);

                        Navigator.pop(context);
                      },
                      child: Text('Update'),
                      textColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
