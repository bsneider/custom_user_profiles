import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'managers/dialog_manager.dart';
import 'app/router.gr.dart';
import 'app/locator.dart';

void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo It Up Fire',
      // builder: (context, child) => Navigator(
      //   key: locator<DialogService>().dialogNavigationKey,
      //   onGenerateRoute: (settings) => MaterialPageRoute(
      //       builder: (context) => DialogManager(child: child)),
      // ),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 9, 202, 172),
        backgroundColor: Color.fromARGB(255, 26, 27, 30),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      initialRoute: Routes.startupViewRoute,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
