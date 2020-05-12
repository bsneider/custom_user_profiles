import 'package:auto_route/auto_route_annotations.dart';
import 'package:compound/ui/views/home/home_view.dart';
import 'package:compound/ui/views/startup/startup_view.dart';
import 'package:compound/ui/views/login/login_view.dart';
import 'package:compound/ui/views/signup/signup_view.dart';
import 'package:compound/ui/views/chat/chat_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartUpView startupViewRoute;
  HomeView homeViewRoute;
  LoginView loginViewRoute;
  SignUpView signUpViewRoute;
  ChatView chatView;
}
