import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:compound/ui/views/signup/signup_viewmodel.dart';
import 'package:compound/forms/user_form.dart';
import 'package:compound/ui/shared/app_colors.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: UserForm(),
            ),
            appBar: AppBar(
              backgroundColor: primaryColor,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      model.navigateToLogin();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Login'))
              ],
            ),
          )),
    );
  }
}
