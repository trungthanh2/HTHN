import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Khai báo 1 lần

  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web đăng nhập bằng popup
        final GoogleAuthProvider authProvider = GoogleAuthProvider();
        UserCredential userCredential = await _auth.signInWithPopup(authProvider);
        return userCredential.user;
      } else {
        // Mobile đăng nhập bằng GoogleSignIn
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          print('Đăng nhập bị huỷ.');
          return null;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print('Đăng nhập lỗi: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    if (!kIsWeb) {
      await _googleSignIn.signOut();
    }
  }

  Stream<User?> get userChanges => _auth.userChanges();
}
