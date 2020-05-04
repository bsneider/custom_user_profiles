// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:compound/services/authentication_service.dart';
import 'package:compound/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AuthenticationService>(
      () => thirdPartyServicesModule.authenticationService);
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<FirestoreService>(
      () => thirdPartyServicesModule.firestoreService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  AuthenticationService get authenticationService => AuthenticationService();
  @override
  DialogService get dialogService => DialogService();
  @override
  FirestoreService get firestoreService => FirestoreService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
