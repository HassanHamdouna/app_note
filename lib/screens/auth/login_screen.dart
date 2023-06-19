import 'package:app_note/firebase/fb_auth_controller.dart';
import 'package:app_note/models/fb_response.dart';
import 'package:app_note/pref/shared_Controller.dart';
import 'package:app_note/provider/languge_provider.dart';
import 'package:app_note/utils/context_extenssion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  bool _obscure = true;
  late String _language;

  @override
  void initState() {
    super.initState();
    _language = SharedController().getValueFor(PrefKey.lagCode.name) ?? 'en';
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.login),
        actions: [
          IconButton(
            onPressed: () {
              _showLanguageBottomSheet();
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localizations.login_title,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
              Text(
                context.localizations.login_subtitle,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                hint: context.localizations.email,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailTextController,
              ),
              SizedBox(height: 10.h),
              AppTextField(
                hint: context.localizations.password,
                obscureText: _obscure,
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.text,
                controller: _passwordTextController,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => _obscure = !_obscure);
                  },
                  icon: const Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => _performLogin(),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r))),
                child: Text(
                  context.localizations.login,
                  style: GoogleFonts.cairo(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.localizations.new_account_message),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/register_screen'),
                    child: Text(context.localizations.create_account),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageBottomSheet() async {
    String? langCode = await showModalBottomSheet<String>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localizations.language_title,
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        context.localizations.language_sub_title,
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          color: Colors.black45,
                          height: 1.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Divider(),
                      RadioListTile<String>(
                        title: Text('English', style: GoogleFonts.cairo()),
                        value: 'en',
                        groupValue: _language,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() => _language = value);
                            Navigator.pop(context, 'en');
                          }
                        },
                      ),
                      RadioListTile<String>(
                        title: Text('العربية', style: GoogleFonts.cairo()),
                        value: 'ar',
                        groupValue: _language,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() => _language = value);
                            Navigator.pop(context, 'ar');
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );

    if (langCode != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Provider.of<LanguageProvider>(context, listen: false).changeLanguage();
      });
    }
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _login() async {
    FbResponse response = await FbAuthController().singIn(_emailTextController.text, _passwordTextController.text);
    if(response.success){
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
    context.showSnackBar(message: response.message, error: !response.success);
    print('object${response.message}');
  }
}
