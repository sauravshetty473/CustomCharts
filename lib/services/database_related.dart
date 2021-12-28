import 'package:cloud_firestore/cloud_firestore.dart';

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
