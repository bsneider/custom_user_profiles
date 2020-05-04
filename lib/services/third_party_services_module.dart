import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/authentication_service.dart';

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
