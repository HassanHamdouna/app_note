import 'package:app_note/models/fb_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FbAuthController {
  /// 1) singInWithEmailAndPassword
  /// 2) createAccountWithEmailAndPassword
  /// 3) createAccountWithEmailAndPassword
  /// 4) forgetPassword

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FbResponse> singIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      bool verify = userCredential.user!.emailVerified;
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
      }
      return FbResponse(verify ? 'logged in successfully' : 'Verify your email', verify);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? 'error', false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }
}
