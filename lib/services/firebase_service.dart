import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  //add a user to database
  Future<void> addUser(dynamic data) {
    return users
        .add(data)
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }
}
