import 'package:app_note/models/fb_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FbAuthController {
  /// 1) singInWithEmailAndPassword
  /// 2) createAccountWithEmailAndPassword
  /// 3) createAccountWithEmailAndPassword
  /// 4) forgetPassword

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<FbResponse> createUser(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
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

  User get currentUser => _auth.currentUser!;

  bool get loggedIn => _auth.currentUser != null;

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

  Future<FbResponse> changePassword(
      String oldPassword, String newPassword) async {
    try {
      if (_auth.currentUser == null) {
        return FbResponse('No user currently signed in.', false);
      }
      final emailCredential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password: oldPassword,
      );
      await currentUser.reauthenticateWithCredential(emailCredential);
      await currentUser.updatePassword(newPassword);

      return FbResponse('Password changed successfully', true);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? 'An error occurred', false);
    } catch (e) {
      return FbResponse('Something went wrong', false);
    }
  }
}
