import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compound/models/user.dart';
import 'package:compound/models/message.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  final CollectionReference _messagesCollectionReference =
      Firestore.instance.collection('messages');

  Future addMessage(Message msg) async {
    try {
      await _messagesCollectionReference.add(msg.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getMessages(String email) async {
    try {
      return buildStreamBuilder(email);
    } catch (e) {
      return e.message;
    }
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder(String email) {
    return StreamBuilder<QuerySnapshot>(
      stream: _messagesCollectionReference.orderBy('d').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        List<DocumentSnapshot> docs = snapshot.data.documents;

        var messages =
            docs.map((doc) => Message.fromData(doc.data, email)).toList();

        return ListView(
          // controller: scrollController,
          children: <Widget>[
            ...messages,
          ],
        );
      },
    );
  }
}
