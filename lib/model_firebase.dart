import 'package:flutter/material.dart';
import 'model/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class modelFireBase {
  CollectionReference dbReplies = Firestore.instance.collection('replies');
  
  Future <void> insertFirestoreItem(Todo todo)async{
    CollectionReference events = Firestore.instance.collection('Calendar Events');
    var newDocument = await events.add(todo.toMap());
    print(newDocument);
    /*
    Firestore.instance.runTransaction((Transaction tx) async {
    var _result = await dbReplies.add(todo.toMap());
    print(_result);
    });
    */
  }

  Future <void> deleteFirestoreItem(int id) async{
    CollectionReference events = Firestore.instance.collection('Calendar Events');
    await events.document(id.toString()).delete();
    print("ID has been deleted");
  }
  
}