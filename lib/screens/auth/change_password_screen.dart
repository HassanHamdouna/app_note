import 'package:app_note/firebase/fb_auth_controller.dart';
import 'package:app_note/models/fb_response.dart';
import 'package:app_note/utils/context_extenssion.dart';
import 'package:app_note/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        leadingWidth: 80,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text('Change Password',
                    style: GoogleFonts.ubuntu(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0B2E40),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 29,
                ),
                AppTextField(
                  hint: 'old password',
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.name,
                  focusedBorderColor: const Color(0xffEDEDED),
                  obscureText: false,
                  suffixIcon: null,
                  controller: _oldPasswordController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextField(
                  hint: 'new password',
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.name,
                  focusedBorderColor: const Color(0xffEDEDED),
                  obscureText: false,
                  suffixIcon: null,
                  controller: _newPasswordController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextField(
                  hint: 'confirm password',
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.name,
                  focusedBorderColor: const Color(0xffEDEDED),
                  obscureText: false,
                  suffixIcon: null,
                  controller: _confirmPasswordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _performChangePassword();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff03A7A9),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11))),
                  child: Text(
                    'change Password',
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _performChangePassword() {
    if (_checkDate()) {
      _changePassword();
    }
  }

  bool _checkDate() {
    if (_oldPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (_newPasswordController.text == _confirmPasswordController.text) {
        return true;
      }
      context.showAwesomeDialog(
        message: ' error newPassword != confirm Password',
        error: false,
      );
      return false;
    }
    context.showAwesomeDialog(
      message: 'empty password',
      error: false,
    );
    return false;
  }

  void _changePassword() async {
    FbResponse response = await FbAuthController().changePassword(
        _oldPasswordController.text, _newPasswordController.text);
    if (response.success) {
      // Navigator.pushReplacementNamed(context, '/login_screen');
      context.showAwesomeDialog(
          message: response.message,
          error: true,
          onPressed: () {
            Navigator.pop(context);
          });
    }
    if (!response.success) {
      context.showAwesomeDialog(
        message: response.message,
        error: false,
      );
    }
  }
}
