import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // signinWithgoogle() async {
  //   GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleauth = await googleuser?.authentication;

  //   AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleauth?.accessToken,
  //     idToken: googleauth?.idToken,
  //   );
  //   return _auth.signInWithCredential(credential);
  // }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("user not registered");
    }
  }
}
