import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './animated__card.dart';
import './users_provider.dart';

class CardStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context).users;
    return users.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.perm_identity,
                  size: 100,
                  color: Colors.lightBlue,
                ),
                SizedBox(height: 10,),
                Text("Wait please !" , style: TextStyle(color: Colors.lightBlue ,fontSize: 30 , fontWeight: FontWeight.bold),)
              ],
            ),
          )
        : Stack(children: users.map((user) => AnimatedCard(user)).toList());
  }
}
