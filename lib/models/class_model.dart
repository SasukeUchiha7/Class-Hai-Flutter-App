import 'package:cloud_firestore/cloud_firestore.dart';

class ClassData {
  String cid;
  String className;
  bool isClass;
  String classLink;
  Timestamp updatedAt;
  String updatedBy;

  ClassData(
      {this.cid,
      this.className,
      this.isClass,
      this.classLink,
      this.updatedAt,
      this.updatedBy});
}
