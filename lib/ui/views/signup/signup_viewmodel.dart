import 'package:compound/app/locator.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:compound/app/router.gr.dart';
import 'package:flutter/foundation.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedRole = 'Select a User Role';
  String get selectedRole => _selectedRole;

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }

  void navigateToLogin() async {
    await _navigationService.navigateTo(Routes.loginViewRoute);
  }
}
