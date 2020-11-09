import 'package:firebase_app1/services/auth.dart';
import 'package:firebase_app1/shared/constraints.dart';
import 'package:firebase_app1/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[500],
              title: Text("Sign Up With BrewCrew"),
              elevation: 0,
              centerTitle: false,
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Sign-In",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: textInputDecor.copyWith(
                              hintText: 'helloworld@example.com'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val.length < 8 ? 'Enter an Valid Password' : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          decoration:
                              textInputDecor.copyWith(hintText: 'Password'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formkey.currentState.validate() == true) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.registerWthEmandPwd(
                                  email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Please Try Again';
                                  loading = false;
                                });
                              }
                            } else {
                              return null;
                            }
                          },
                          color: Colors.red[300],
                          child: Text("Register"),
                        ),
                        Text(
                          error,
                          style:
                              TextStyle(color: Colors.red[800], fontSize: 14.0),
                        )
                      ],
                    ))),
          );
  }
}
