import 'package:compound/ui/views/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends ViewModelBuilderWidget<StartUpViewModel> {
  const StartUpView({Key key}) : super(key: key);
  @override
  bool get reactive => true;
  @override
  bool get disposeViewModel => true;
  @override
  void onViewModelReady(StartUpViewModel s) => s.handleStartUpLogic();
  @override
  Widget builder(BuildContext context, StartUpViewModel model, Widget child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 100,
              child: Image.asset('assets/images/icon_large.png'),
            ),
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(
                Color(0xff19c7c1),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  StartUpViewModel viewModelBuilder(BuildContext context) => StartUpViewModel();
}
