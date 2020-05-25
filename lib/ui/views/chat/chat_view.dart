import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'chat_viewmodel.dart';

class ChatView extends ViewModelBuilderWidget<ChatViewModel> {
  const ChatView({Key key}) : super(key: key);
  @override
  bool get reactive => true;
  @override
  bool get disposeViewModel => true;
  @override
  void onViewModelReady(ChatViewModel s) => s.handleStartUpLogic();
  @override
  Widget builder(BuildContext context, ChatViewModel model, Widget child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: model.buildStreamBuilder(),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => model.callback(),
                      decoration: InputDecoration(
                        hintText: "Enter a Message...",
                        border: const OutlineInputBorder(),
                      ),
                      controller: model.messageController,
                    ),
                  ),
                  SendButton(
                    text: "Send",
                    callback: model.callback,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel();
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.orange,
      onPressed: callback,
      child: Text(text),
    );
  }
}
