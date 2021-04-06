import 'package:class_hai/services/auth.dart';
import 'package:class_hai/shared/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:class_hai/shared/constants.dart';

class SignIn extends StatefulWidget {
  //from authorize
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //to get _auth form auth.dart
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //field states
  bool remember = false;
  String error = '';
  bool loading = false;
  //creds
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    //size of device
    Size size = MediaQuery.of(context).size;
    int height = size.height.round();
    double width = size.width;

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.fromLTRB(30, 200, 50, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'EMAIL',
                      style: inputTextLabel,
                    ),
                    SizedBox(height: 2.0),
                    Row(
                      children: [
                        Icon(Icons.mail_outline, color: Colors.grey[700]),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            decoration: inputTextDecoration.copyWith(
                                hintText: 'example@net.in'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a valid e-mail' : null,
                            onChanged: (val) => {setState(() => email = val)},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'PASSWORD',
                      style: inputTextLabel,
                    ),
                    SizedBox(height: 2.0),
                    Row(
                      children: [
                        Icon(Icons.lock_outline, color: Colors.grey[700]),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            decoration: inputTextDecoration.copyWith(
                                hintText: '********'),
                            validator: (val) => val.isEmpty
                                ? 'Password must be greater than 6 characters'
                                : null,
                            obscureText: true,
                            onChanged: (val) =>
                                {setState(() => password = val)},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: remember,
                          onChanged: (val) => setState(() => remember = val),
                        ),
                        Text('Keep me logged in',style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    Center(
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: buttonColor,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.signInUser(email, password);
                            if (result == null) {
                              setState(() => {
                                    loading = false,
                                    error =
                                        "Could not find the account with this credentials",
                                  });
                            }
                          }
                        },
                        child: Text('Sign In'),
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                        child: RichText(
                      text: TextSpan(
                        text: "Dont't have a account?",
                        style: TextStyle(color: Colors.grey),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.toggleView();
                          },
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
  }
}
