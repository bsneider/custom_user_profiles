import 'package:compound/app/locator.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:compound/app/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compound/models/message.dart';
import 'package:compound/models/user.dart';

class ChatViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future nagivateToHome() async {
    await _navigationService.navigateTo(Routes.homeViewRoute);
  }

  List<Widget> _msgsListView;
  List<Widget> get msgs => _msgsListView;
  User _user;
  Future handleStartUpLogic() async {
    _user = _authenticationService.currentUser;
    // _msgsListView = await _firestoreService.getMessages(_user.email);
  }

  final CollectionReference _messagesCollectionReference =
      Firestore.instance.collection('messages');

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _messagesCollectionReference.add(
          Message(text: messageController.text, from: _user.email).toJson());
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: _messagesCollectionReference.orderBy('d').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        List<DocumentSnapshot> docs = snapshot.data.documents;

        List<Widget> messages = docs
            .map((doc) => Message.fromData(
                doc.data, _authenticationService.currentUser.email))
            .toList();

        return ListView(
          controller: scrollController,
          children: <Widget>[
            ...messages,
          ],
        );
      },
    );
  }
}
