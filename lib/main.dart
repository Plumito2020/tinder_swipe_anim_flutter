import 'package:flutter/material.dart';

import './card_profile.dart';
import './users_provider.dart';
import 'package:provider/provider.dart';
import './cards_stack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Users(),
      child: MaterialApp(
        title: 'Tinter',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          backgroundColor: Colors.lightBlue[50],
          appBar: AppBar(
            title: Text(
              "Tinter",
              style: TextStyle(color: Colors.lightBlue[50]),
            ),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
          body: CardStack(),
        ),
        routes: {
          "/profile": (_) => CardProfile(),
        },
      ),
    );
  }
}
