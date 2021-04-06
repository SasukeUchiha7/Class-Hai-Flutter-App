import 'package:flutter/material.dart';

class SubjectProfile extends StatefulWidget {
  @override
  _SubjectProfileState createState() => _SubjectProfileState();
}

class _SubjectProfileState extends State<SubjectProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // IconButton(icon: Icon(Icons.arrow_back_ios_outlined), onPressed: (){}),
              Text(
                'Computer Networks',
                style: TextStyle(fontSize: 20),
              ),
              Icon(Icons.notifications_none_outlined),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[50],
        ),
      ),
    );
  }
}
