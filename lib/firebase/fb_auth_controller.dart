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

  Future<FbResponse> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(
          facebookAuthCredential,
        );

        bool verify = userCredential.user != null;

        return FbResponse(
          verify ? 'logged in successfully' : 'Verify your email',
          verify,
        );
      } else if (result.status == LoginStatus.cancelled) {
        return FbResponse('Facebook login was canceled', false);
      } else {
        return FbResponse('Facebook login failed. Please try again.', false);
      }
    } on FirebaseAuthException catch (e) {
      print('message error${e.message}');
      return FbResponse(
          e.message ?? 'Error occurred during Facebook login', false);
    } catch (e) {
      print('error${e.toString()}');
      return FbResponse('Something went wrong: ${e.toString()}', false);
    }
  }

 /* Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']);
    if (result.accessToken != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      return await _auth.signInWithCredential(facebookAuthCredential);
    } else {
      throw Exception('Failed to retrieve Facebook access token');
    }
  }*/

  Future<FbResponse> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email']).signIn();

      if (googleUser == null) {
        return FbResponse('Google Sign-In canceled or failed', false);
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        return FbResponse(
            'Google Sign-In failed to get required authentication data', false);
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken!,
        idToken: googleAuth.idToken!,
      );

      final UserCredential userGoogle =
          await _auth.signInWithCredential(credential);
      bool verify = userGoogle.user != null;

      return FbResponse(
          verify ? 'logged in successfully' : 'Verify your email', verify);
    } on FirebaseAuthException catch (e) {
      print('message error${e.message}');

      return FbResponse(e.message ?? 'error', false);
    } catch (e) {
      print('error${e.toString()}');
      return FbResponse('Something went Wrong${e.toString()}', false);
    }
  }

  // Future<FbResponse> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser =
  //         await GoogleSignIn(scopes: ['email']).signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;
  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final UserCredential userGoogle =
  //         await _auth.signInWithCredential(credential);
  //     final oauthCredentials = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //       accessToken: googleAuth.accessToken,
  //     );
  //     await FirebaseAuth.instance.signInWithCredential(
  //       oauthCredentials,
  //     );
  //     bool verify = userGoogle.user != null;
  //
  //     return FbResponse(
  //         verify ? 'logged in successfully' : 'Verify your email', verify);
  //   } on FirebaseAuthException catch (e) {
  //     return FbResponse(e.message ?? 'error', false);
  //   } catch (e) {
  //     print('error sds${e.toString()}');
  //     return FbResponse('Something went Wrong${e.toString()}', false);
  //   }
  // }

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
}
