import 'package:compound/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:compound/app/router.gr.dart';

class SignUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToLogin() async {
    await _navigationService.navigateTo(Routes.loginViewRoute);
  }
}
