import 'package:flutter/material.dart';
import 'package:watch_me_travel/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:watch_me_travel/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
