import 'package:flutter/material.dart';
import 'package:compound/ui/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.initialize(),
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Text(model.title),
              ),
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () async {
                        model.signOut();
                      },
                      icon: Icon(Icons.person),
                      label: Text('logout'))
                ],
              ),
            ));
  }
}
