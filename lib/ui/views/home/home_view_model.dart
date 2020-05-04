import 'package:compound/app/locator.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:compound/app/router.gr.dart';

class HomeViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String title = 'Home View';
  void initialize() {
    title = 'initialized';
    notifyListeners();
  }

  Future signOut() async {
    try {
      setBusy(true);
      return await _authenticationService.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      setBusy(false);
      await _navigationService.navigateTo(Routes.signUpViewRoute);
    }
  }
}
