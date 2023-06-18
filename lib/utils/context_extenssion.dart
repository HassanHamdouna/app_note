import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/core/launch_screen.dart';

extension ContextHelper on BuildContext {
  Map<String, WidgetBuilder> get rout => {
        '/launch_screen': (context) => const LaunchScreen(),
        '/register_screen': (context) => const LaunchScreen(),
        '/login_screen': (context) => const LaunchScreen(),
        '/home_screen': (context) => const LaunchScreen(),
      };

  ThemeData get themData => ThemeData(
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20,
        ),
        titleTextStyle: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
        centerTitle: true,
      ));

  void showSnackBar({required String massage, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(massage,
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
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(milliseconds: 800),
    ));
  }
}

