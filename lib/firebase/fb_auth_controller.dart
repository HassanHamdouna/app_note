import 'package:app_note/models/fb_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FbAuthController {
  /// 1) singInWithEmailAndPassword
  /// 2) createAccountWithEmailAndPassword
  /// 3) createAccountWithEmailAndPassword
  /// 4) forgetPassword

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
// new
  Future<FbResponse> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userGoogle = await _auth.signInWithCredential(credential);
      bool verify = userGoogle.user!=null;
      // bool verify = userGoogle!=null;

      return FbResponse(
          verify ? 'logged in successfully' : 'Verify your email', verify);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? 'error', false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }

  Future<FbResponse> singIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      bool verify = userCredential.user!.emailVerified;
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        await _auth.signOut();
      }
      return FbResponse(
          verify ? 'logged in successfully' : 'Verify your email', verify);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? 'error', false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }

  Future<FbResponse> createUser(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.sendEmailVerification();
      return FbResponse('Registered successfully , verify email ', true);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? 'error', false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  User get currentUser =>  _auth.currentUser!;
  bool get loggedIn =>  _auth.currentUser  !=null;

  Future<FbResponse> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return FbResponse('Rest email send successfully ', true);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? "error", false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }
}
