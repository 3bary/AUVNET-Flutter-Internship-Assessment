import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    final creds = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return creds.user;
  }

  Future<User?> login(String email, String password) async {
    final creds = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return creds.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
