import 'package:auto_route/auto_route_annotations.dart';

import '../ui/views/chat/chat_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartUpView startupViewRoute;
  HomeView homeViewRoute;
  LoginView loginViewRoute;
  SignUpView signUpViewRoute;
  ChatView chatView;
}
