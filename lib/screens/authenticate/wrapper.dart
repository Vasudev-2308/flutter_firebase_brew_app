import 'package:firebase_app1/models/user.dart';
import 'package:firebase_app1/screens/authenticate/authenticate.dart';
import 'package:firebase_app1/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    print(user);
    //Return either Home or Auth based on Auth status
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
