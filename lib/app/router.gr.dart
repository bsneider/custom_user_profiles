// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:compound/ui/views/startup/startup_view.dart';
import 'package:compound/ui/views/home/home_view.dart';
import 'package:compound/ui/views/login/login_view.dart';
import 'package:compound/ui/views/signup/signup_view.dart';
import 'package:compound/ui/views/chat/chat_view.dart';

abstract class Routes {
  static const startupViewRoute = '/';
  static const homeViewRoute = '/home-view-route';
  static const loginViewRoute = '/login-view-route';
  static const signUpViewRoute = '/sign-up-view-route';
  static const chatView = '/chat-view';
  static const all = {
    startupViewRoute,
    homeViewRoute,
    loginViewRoute,
    signUpViewRoute,
    chatView,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.startupViewRoute:
        if (hasInvalidArgs<StartUpViewArguments>(args)) {
          return misTypedArgsRoute<StartUpViewArguments>(args);
        }
        final typedArgs =
            args as StartUpViewArguments ?? StartUpViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => StartUpView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.homeViewRoute:
        if (hasInvalidArgs<HomeViewArguments>(args)) {
          return misTypedArgsRoute<HomeViewArguments>(args);
        }
        final typedArgs = args as HomeViewArguments ?? HomeViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.loginViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case Routes.signUpViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignUpView(),
          settings: settings,
        );
      case Routes.chatView:
        if (hasInvalidArgs<ChatViewArguments>(args)) {
          return misTypedArgsRoute<ChatViewArguments>(args);
        }
        final typedArgs = args as ChatViewArguments ?? ChatViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => ChatView(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//StartUpView arguments holder class
class StartUpViewArguments {
  final Key key;
  StartUpViewArguments({this.key});
}

//HomeView arguments holder class
class HomeViewArguments {
  final Key key;
  HomeViewArguments({this.key});
}

//ChatView arguments holder class
class ChatViewArguments {
  final Key key;
  ChatViewArguments({this.key});
}
