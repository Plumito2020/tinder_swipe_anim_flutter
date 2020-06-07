import 'package:flutter/material.dart';

import './user.dart';

class Users with ChangeNotifier {
  List<User> _users = [
    User(id: "1", name: "Zack", bio: "My name is Zack !" ),
    User(id: "2", name: "John", bio: "My name is John!"),
    User(id: "3", name: "Ahmed", bio: "My name is Ahmed !"),
    User(id: "4", name: "Paul", bio: "My name is Paul !"),
  ];

  List<User> _usersStack = [];

  List<User> get users {
    return [..._users];
  }

  List<User> get usersStack {
    return [..._usersStack];
  }

  void loadUsersStack() {
    _usersStack = [..._users];
    notifyListeners();
  }

  void deleteFromStack(String id) {
    _users.removeWhere((user) => user.id == id);
    notifyListeners();
  }
}
