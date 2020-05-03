import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/busy_button.dart';
import 'package:compound/ui/widgets/expansion_list.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:compound/viewmodels/signup_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:compound/ui/shared/shared_styles.dart';

enum Ranks {
  E1,
  E2,
  E3,
  E4,
  E5,
  E6,
  E7,
  E8,
  E9,
  W1,
  W2,
  W3,
  W4,
  W5,
  O1,
  O2,
  O3,
  O4,
  O5,
  O6,
  O7,
  O8,
  O9,
}

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
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
                  items: Ranks.values.map((e) => e.toString()).toList(),
                  title: model.selectedRole,
                  onItemSelected: model.setSelectedRole),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BusyButton(
                    title: 'Sign Up',
                    busy: model.busy,
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
          ),
        ),
      ),
    );
  }
}
