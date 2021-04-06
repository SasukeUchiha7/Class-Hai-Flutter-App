import 'package:class_hai/models/class_model.dart';
import 'package:class_hai/screens/home/class_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassList extends StatefulWidget {
  final String username;
  ClassList({this.username});
  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) {
    final classes = Provider.of<List<ClassData>>(context) ?? [];
    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        return ClassTile(cls: classes[index], username: widget.username);
      },
    );
  }
}
