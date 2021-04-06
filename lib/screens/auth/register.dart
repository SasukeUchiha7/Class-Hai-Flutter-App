import 'package:class_hai/shared/constants.dart';
import 'package:class_hai/shared/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:class_hai/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //to get _auth form auth.dart
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //form states
  bool agree = false;
  String url = 'https://google.com/';
  String error = '';
  bool loading = false;

  //creds
  String name = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    //size of device
    // print(height / 4);
    // print(width / 12);

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 100, 50, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand'),
                      ),
                      SizedBox(height: 40.0),
                      Text(
                        'FULL NAME',
                        style: inputTextLabel,
                      ),
                      SizedBox(height: 2.0),
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: Colors.grey[700]),
                          SizedBox(width: 10),
                          Flexible(
                            child: TextFormField(
                              decoration: inputTextDecoration.copyWith(
                                  hintText: 'Your Name'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter a name' : null,
                              onChanged: (val) => {
                                setState(() => name = val),
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
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
                              obscureText: true,
                              decoration: inputTextDecoration.copyWith(
                                  hintText: '********'),
                              validator: (val) => val.isEmpty
                                  ? 'Password must be greater than 6 characters'
                                  : null,
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
                            value: agree,
                            onChanged: (val) => setState(() => agree = val),
                          ),
                          RichText(
                              text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                text: "Terms of Service",
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    if (await canLaunch(url)) await launch(url);
                                  },
                              ),
                            ],
                          ))
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
                              dynamic result = await _auth.registerUser(
                                  email, password, name);
                              if (result == null) {
                                setState(() => {
                                      loading = false,
                                      error =
                                          "Unable to register with this credentials",
                                    });
                              }
                            }
                            else{
                              
                            }
                          },
                          child: Text('Sign Up'),
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        child: Center(
                            child: Text(
                          'Already a member?',
                          style: TextStyle(color: Colors.grey),
                        )),
                        onTap: () {
                          widget.toggleView();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
