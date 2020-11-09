import 'package:firebase_app1/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app1/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final datas = Provider.of<List<Brew>>(context) ?? [];
    datas.forEach((data) {
      print(data.name);
      print(data.sugars);
      print(data.strength);
    });
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (context, index) {
        return BrewTile(
          brew: datas[index],
        );
      },
    );
  }
}
