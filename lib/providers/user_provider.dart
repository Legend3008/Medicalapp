import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String? _userId;
  String? _name;
  String? _email;
  bool _isAuthenticated = false;

  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  bool get isAuthenticated => _isAuthenticated;

  void setUser({
    required String userId,
    required String name,
    required String email,
  }) {
    _userId = userId;
    _name = name;
    _email = email;
    _isAuthenticated = true;
    notifyListeners();
  }

  void clearUser() {
    _userId = null;
    _name = null;
    _email = null;
    _isAuthenticated = false;
    notifyListeners();
  }
} 