import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:compound/models/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:compound/ui/shared/shared_styles.dart';
import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:compound/app/router.gr.dart';
import 'package:compound/app/locator.dart';

class UserForm extends StatefulWidget {
  UserForm({Key key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rankController = TextEditingController();
  final _genderController = TextEditingController();
  final _serviceBranchController = TextEditingController();

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
  User _user = User();
  User get user => _user;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        verticalSpaceMedium,
        Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            autovalidate: true,
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
                  onSaved: (val) => _user.email = val,
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
                      val.length > 6 ? null : 'must be longer than 6 chars',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        onSaved: (val) => _user.rank = val,
                        value: allRanksInOrder.first,
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
                            _user.rank = val;
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          onSaved: (val) => _user.serviceBranch = val,
                          value: 'Air Force',
                          items: [
                            'Air Force',
                            'Army',
                            'Coast Guard',
                            'Marine Corps',
                            'National Guard',
                            'Navy',
                            'Space Force'
                          ].map<DropdownMenuItem<String>>(
                            (String val) {
                              return DropdownMenuItem(
                                child: Text(val),
                                value: val,
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(() {
                              _user.serviceBranch = val;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Service Branch',
                            icon: Icon(Icons.flare),
                          ),
                        ),
                      )
                    ]),
                verticalSpaceMedium,
                submit(context),
              ],
            ),
          ),
        )
      ],
    );
  }

  Row submit(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: loading
                ? SpinKitWave(
                    color: Colors.white,
                    size: 15.0,
                  )
                : Text('Sign Up'),
            color: Colors.pinkAccent,
            textColor: Colors.white,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  loading = true;
                });
                _formKey.currentState.save();
                var signUpResponse = await _authenticationService.signUpWithEmail(
                    user: _user, password: _passwordController.text);
                var snackBarText = signUpResponse.toString == 'true' ? 'Signed Up' : signUpResponse;
                Timer(Duration(seconds: 2), () async {
                  setState(() {
                    loading = false;
                  });
                  final snackBar = SnackBar(content: Text(snackBarText));
                  Scaffold.of(context).showSnackBar(snackBar);
                  print('Saved');
                  await _navigationService.navigateTo(Routes.homeViewRoute);
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
