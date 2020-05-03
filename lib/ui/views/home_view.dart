import 'package:flutter/material.dart';
import 'package:compound/viewmodels/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Text('Home'),
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
