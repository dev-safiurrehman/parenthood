import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:parenthood/model/todo_model.dart';


class TodoDatabase {
  //push data to database
  Future<void> addData(
      String title, String description, String date, String time, String? iconUrl) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.currentUser!;
    final String uid = user.uid;

    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users').doc(uid).collection('todo');
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(date);
    await collectionReference.add({
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(dateTime),
      'time': time,
      'iconUrl': iconUrl,
    });
  }

  // final TodoModel todoModel = TodoModel();
  //get data from database
  Future getData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.currentUser!;
    final String uid = user.uid;
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users').doc(uid).collection('todo');
    QuerySnapshot snapshot =
        await collectionReference.doc(uid).collection('users').doc(uid).collection('todo').get();
    print('This is Snapshot ${snapshot}');
    return snapshot.docs;
  }

  //delete data from database
  Future<void> deleteData(String id) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.currentUser!;
    final String uid = user.uid;
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users').doc(uid).collection('todo');
    await collectionReference
        .doc(uid)
        .collection('todo')
        .doc(id)
        .delete(); //delete data
  }
}
