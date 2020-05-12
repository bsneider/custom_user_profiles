import 'package:compound/app/locator.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:compound/app/router.gr.dart';

class StartUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future nagivateToHome() async {
    await _navigationService.navigateTo(Routes.homeViewRoute);
  }

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      await _navigationService.navigateTo(Routes.chatView);
      // await _navigationService.navigateTo(Routes.homeViewRoute);
    } else {
      await _navigationService.navigateTo(Routes.loginViewRoute);
    }
  }
}
