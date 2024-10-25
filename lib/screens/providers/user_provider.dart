import 'package:flutter/cupertino.dart';
import 'package:teste/screens/bd/user.dart';
import 'package:teste/screens/resources/auth.dart';

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
