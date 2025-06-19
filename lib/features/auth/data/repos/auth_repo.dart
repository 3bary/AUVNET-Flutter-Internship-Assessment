// lib/features/auth/data/repos/auth_repo.dart
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/auth_exception.dart';
import '../../../../core/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseService;

  AuthRepository(this._firebaseService);

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'user-disabled':
        return 'This account has been disabled.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      final user = await _firebaseService.signUp(email, password);
      if (user == null) throw AuthException('Signup failed: User not created');
      return user.uid;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseError(e));
    } catch (e) {
      throw AuthException('An unexpected error occurred during signup');
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final user = await _firebaseService.login(email, password);
      if (user == null) throw AuthException('Login failed: User not found');
      return user.uid;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseError(e));
    } catch (e) {
      throw AuthException('An unexpected error occurred during login');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseService.logout();
    } catch (e) {
      throw AuthException('Failed to logout. Please try again.');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseService.sendPasswordResetEmail(email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseError(e));
    } catch (e) {
      throw AuthException('Failed to send password reset email');
    }
  }
}
