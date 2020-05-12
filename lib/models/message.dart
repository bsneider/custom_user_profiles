import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final String from;
  DateTime date;
  bool me;
  Message({this.text, this.from}) {
    this.date = DateTime.now();
  }

  Message.fromData(Map<String, dynamic> data, String email)
      : text = data['t'],
        from = data['f'],
        date = DateTime.parse(data['d']),
        me = data['f'] == email;

  Map<String, dynamic> toJson() {
    return {
      't': text,
      'f': from,
      'd': date.toIso8601String().toString(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
          ),
          Material(
            color: me ? Colors.teal : Colors.red,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                text,
              ),
            ),
          )
        ],
      ),
    );
  }
}
