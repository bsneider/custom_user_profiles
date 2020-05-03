import 'package:compound/locator.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/constants/route_names.dart';

import 'base_model.dart';

class HomeViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() async {
    try {
      setBusy(true);
      return await _authenticationService.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      setBusy(false);
      _navigationService.navigateTo(SignUpViewRoute);
    }
  }
}
