import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../app/router.gr.dart';
import '../../../services/authentication_service.dart';

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
