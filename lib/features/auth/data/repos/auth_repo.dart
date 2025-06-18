import '../../../../core/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseService;

  AuthRepository(this._firebaseService);

  Future<String?> signUp(String email, String password) async {
    try {
      final user = await _firebaseService.signUp(email, password);
      return user?.uid;
    } catch (e) {
      return 'Signup failed: ${e.toString()}';
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final user = await _firebaseService.login(email, password);
      return user?.uid;
    } catch (e) {
      return 'Login failed: ${e.toString()}';
    }
  }

  Future<void> logout() => _firebaseService.logout();
}
