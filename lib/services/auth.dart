import 'package:class_hai/models/user_model.dart';
import 'package:class_hai/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //simple user model for 'User'firebase
  UserId _userfromFUser(User user) {
    //print(user.uid);
    return user != null
        ? UserId(
            uid: user.uid,
          )
        : null;
  }

  //stream for user login logout changes
  Stream<UserId> get user {
    return _auth.authStateChanges().map((User user) => _userfromFUser(user));
  }

  //sign in with email and pass
  Future signInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userfromFUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and pass
  Future registerUser(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print(user);

      //make database of the user.
      await DatabaseService(uid: user.uid).updateUserData(name);
      //return user model form User
      return _userfromFUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //logout
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
