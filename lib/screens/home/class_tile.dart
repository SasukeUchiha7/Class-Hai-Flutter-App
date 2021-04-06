import 'package:class_hai/models/class_model.dart';
import 'package:class_hai/screens/home/settings.dart';
import 'package:class_hai/screens/subject/subject_profile.dart';
import 'package:class_hai/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class ClassTile extends StatelessWidget {
  //values from Classlist
  final ClassData cls;
  final String username;
  ClassTile({this.cls, this.username});

  @override
  Widget build(BuildContext context) {
    final String up =
        timeago.format(cls.updatedAt.toDate().subtract(Duration(minutes: 1)));
    //show setting fn
    void _showSetting() {
      showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingForm(cls: cls, username: username),
            );
          });
    }

    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(20, 6, 20, 5),
          child: ExpansionTile(
            childrenPadding: EdgeInsets.all(10),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/${cls.cid}.jpg'),
              backgroundColor: Colors.green[100],
            ),
            trailing: SizedBox.shrink(),
            title: Text(
              cls.className,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            subtitle: cls.isClass
                ? Text(
                    'There is a class today',
                    style: TextStyle(color: Colors.green),
                  )
                : Text(
                    'There is no class today',
                    style: TextStyle(color: Colors.red),
                  ),
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cls.isClass
                  ? Container(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Class Link ',
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: cardInputContainer(Text(cls.classLink))),
                            IconButton(
                                icon: Icon(Icons.send),
                                color: Colors.cyan[900],
                                onPressed: () async {
                                  if (await canLaunch('${cls.classLink}'))
                                    await launch('${cls.classLink}');
                                }),
                          ],
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ))
                  : SizedBox.shrink(),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Updated By ',
                    style: TextStyle(
                        fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  cardInputContainer(Text(cls.updatedBy)),
                ],
              )),
              SizedBox(height: 15.0),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Updated ',
                      style: TextStyle(
                          fontFamily: 'OpenSans', fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.0),
                  cardInputContainer(Text(up)),
                ],
              )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/subject');
                      },
                      icon: Icon(Icons.assessment_outlined),
                      label: Text('Asssignment')),
                  FlatButton.icon(
                      onPressed: () => _showSetting(),
                      icon: Icon(Icons.update),
                      label: Text('Update')),
                ],
              ),
            ],
          ),
        ));
  }
}
