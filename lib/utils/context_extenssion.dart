import 'package:app_note/screens/app/home_screen.dart';
import 'package:app_note/screens/app/note_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/core/launch_screen.dart';

extension ContextHelper on BuildContext {
  Map<String, WidgetBuilder> get rout => {
        '/launch_screen': (context) => const LaunchScreen(),
        '/register_screen': (context) => const RegisterScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/note_screen': (context) =>  NoteScreen(),
      };


  ThemeData get themData => ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.poppins()
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20,
        ),
        titleTextStyle: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
        centerTitle: true,
      ));



  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message,
          style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white)),
      elevation: 5,
      backgroundColor: error ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(milliseconds: 2000),
    ));
  }

  AppLocalizations  get localizations  {
    return AppLocalizations.of(this)!;

  }
}

