import 'package:class_hai/models/class_model.dart';
import 'package:class_hai/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //class id;
  final String cid;
  final String uid;
  DatabaseService({this.cid, this.uid});

  //collection references
  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('classes');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //update fnt for class data upadte------------------------
  Future updateClassData(
    String className,
    bool isClass,
    String classLink,
    Timestamp updatedAt,
    String updatedBy
  ) async {
    return await classCollection.doc(cid).set({
      'className': className,
      'isClass': isClass,
      'classLink': classLink,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy
    });
  }

  //update fn for user data
  Future updateUserData(String name) async {
    //print('----->$uid');
    return userCollection.doc(uid).set({'name': name});
  }
  //---------------------------------------------------------

  //snapshot for class data changes
  List<ClassData> _classListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((cls) {
      return ClassData(
        className: cls.data()['className'] ?? 'Class Name',
        isClass: cls.data()['isClass'] ?? false,
        classLink: cls.data()['classLink'] ?? "gmeet.com/classlink",
        updatedAt:
            cls.data()['updatedAt'] ?? DateTime.now().millisecondsSinceEpoch,
        cid: cls.id,
        updatedBy: cls.data()['updatedBy'] ?? 'None',
      );
    }).toList();
  }

  //class data from querysnapshot
  ClassData _classDataFromSnapshot(DocumentSnapshot snapshot) {
    return ClassData(
      cid: cid,
      isClass: snapshot.data()['isClass'],
    );
  }

  //user data from querysnapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'] ?? 'User',
    );
  }

  // Streams----------------------------------------------
  //stream for class snapshots
  Stream<List<ClassData>> get classes {
    return classCollection.snapshots().map(_classListfromSnapshot);
  }

  //classData stream for modalbottomsettings
  Stream<ClassData> get cls {
    return classCollection.doc(cid).snapshots().map(_classDataFromSnapshot);
  }

  //userdata steam for geting user data
  Stream<UserData> get userData {
    userCollection.doc(uid).snapshots().forEach((element) {
     // print(element.id);
    });
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
  //------------------------------------------------------
}
