import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../app/router.gr.dart';
import '../../../models/message.dart';
import '../../../models/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/firestore_service.dart';

class ChatViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
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
