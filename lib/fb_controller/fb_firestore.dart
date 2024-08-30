import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/Debts_model.dart';



class FbFirestoreController{
  ///Functions
  ///1) Create
  ///2) Read
  ///3) Update
  ///4) Delete

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot<Debts>> readDebts() async* {
    yield* _firestore
        .collection('contact')
        .withConverter<Debts>(
      fromFirestore: (snapshot, options) => Debts.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();
  }



}
