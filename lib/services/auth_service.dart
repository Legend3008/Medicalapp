import 'package:flutter/foundation.dart';

class AuthService {
  // Simulated authentication state stream
  Stream<bool> get authStateChanges => Stream.periodic(
    const Duration(seconds: 2),
    (count) => true,
  ).take(1);

  Future<bool> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> signUp(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }
} 