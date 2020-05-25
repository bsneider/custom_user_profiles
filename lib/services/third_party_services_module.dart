import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'authentication_service.dart';
import 'firestore_service.dart';

@registerModule
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackBarService;
  @lazySingleton
  FirestoreService get firestoreService;
  @lazySingleton
  AuthenticationService get authenticationService;
}
