import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:compound/models/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:compound/ui/shared/shared_styles.dart';
import 'package:compound/ui/shared/ui_helpers.dart';

class UserForm extends StatefulWidget {
  UserForm({Key key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  static final _enlistedRanks =
      List.generate(9, (int index) => 'E-' + (index + 1).toString());
  static final _warrantRanks =
      List.generate(5, (int index) => 'W-' + (index + 1).toString());
  static final _officerRanks =
      List.generate(9, (int index) => 'O-' + (index + 1).toString());
  final List<String> allRanksInOrder = []
    ..addAll(_enlistedRanks)
    ..addAll(_warrantRanks)
    ..addAll(_officerRanks);

  String _rank;
  User _user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Full Name', icon: Icon(Icons.account_circle)),
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email', icon: Icon(Icons.email)),
                  validator: (val) => EmailValidator.validate(val)
                      ? null
                      : 'Enter a valid email',
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password', icon: Icon(Icons.vpn_key)),
                  validator: (val) =>
                      val.length < 6 ? null : 'Enter a valid email',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        onSaved: (val) => _user.rank = val,
                        value: _rank,
                        items: allRanksInOrder.map<DropdownMenuItem<String>>(
                          (String val) {
                            return DropdownMenuItem(
                              child: Text(val),
                              value: val,
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(() {
                            _rank = val;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Rank',
                          icon: Icon(Icons.work),
                        ),
                      ),
                    ),
                    horizontalSpaceMedium,
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        onSaved: (val) => _user.male = val == 'Male',
                        value: 'Male',
                        items: ['Male', 'Female'].map<DropdownMenuItem<String>>(
                          (String val) {
                            return DropdownMenuItem(
                              child: Text(val),
                              value: val,
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(() {
                            _user.male = val == 'Male';
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Gender',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
