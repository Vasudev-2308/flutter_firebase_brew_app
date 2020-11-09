import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app1/models/brew.dart';
import 'package:firebase_app1/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServive {
  final String uid;
  DatabaseServive({this.uid});
  // Collection Reference
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection("data");

  Future updateUserData(
    String sugar,
    String name,
    int strength,
  ) async {
    return await dataCollection
        .doc(uid)
        .set({'sugars': sugar, 'name': name, 'strength': strength});
  }

  //Brew List from SnapShot
  List<Brew> _brewListfromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.data()['name'] ?? '',
          strength: doc.data()['strength'] ?? 0,
          sugars: doc.data()['sugar'] ?? '0');
    }).toList();
  }

  // Get Brews Stream
  Stream<List<Brew>> get data {
    return dataCollection.snapshots().map(_brewListfromSnapshots);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        sugars: snapshot.data()['sugar'],
        strength: snapshot.data()['strength']);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return dataCollection.doc(uid).snapshots().map((_userDataFromSnapshot));
  }
}
