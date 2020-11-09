import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app1/home/settings_form.dart';
import 'package:firebase_app1/models/brew.dart';
import 'package:firebase_app1/home/brew_list.dart';
import 'package:firebase_app1/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app1/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showEditPreferences() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseServive().data,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          centerTitle: false,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.SignOut();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                )),
            FlatButton.icon(
                onPressed: () {
                  _showEditPreferences();
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Text(''))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/coffee.png'), fit: BoxFit.cover),
            ),
            child: BrewList()),
      ),
    );
  }
}
