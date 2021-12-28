import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }
}

class DatabaseService {
  final CollectionReference userData =
      FirebaseFirestore.instance.collection("UserData");
  final CollectionReference defaultCollection = FirebaseFirestore.instance
      .collection('UserData')
      .doc('1')
      .collection('Collections')
      .doc('My Records')
      .collection('Records');
  final DocumentReference defaultPerson =
      FirebaseFirestore.instance.collection('UserData').doc('1');
}
