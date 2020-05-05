import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/busy_button.dart';
import 'package:compound/ui/widgets/expansion_list.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:compound/ui/views/signup/signup_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:compound/ui/shared/shared_styles.dart';
import 'package:compound/forms/payment_form.dart';
import 'package:compound/forms/user_form.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: UserForm(),

          // buildColumn(model),
        ),
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
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
      ),
    );
  }

  Column buildColumn(SignUpViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 38,
          ),
        ),
        verticalSpaceLarge,
        InputField(
          placeholder: 'Full Name',
          controller: fullNameController,
        ),
        verticalSpaceSmall,
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: textInputDecoration,
          validator: (val) =>
              EmailValidator.validate(val) ? null : 'Enter a valid email',
        ),
        verticalSpaceSmall,
        InputField(
          placeholder: 'Password',
          password: true,
          controller: passwordController,
          additionalNote: 'Password has to be a minimum of 6 characters.',
        ),
        verticalSpaceSmall,
        ExpansionList<String>(
            // items: Ranks.values.map((e) => e.toString()).toList(),
            title: model.selectedRole,
            onItemSelected: model.setSelectedRole),
        verticalSpaceMedium,
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BusyButton(
              title: 'Sign Up',
              // busy: model.busy,
              onPressed: () {
                model.signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    fullName: fullNameController.text);
              },
            )
          ],
        )
      ],
    );
  }
}
