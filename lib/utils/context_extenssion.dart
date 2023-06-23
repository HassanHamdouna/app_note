import 'package:app_note/screens/app/home_screen.dart';
import 'package:app_note/screens/app/images/images_screen.dart';
import 'package:app_note/screens/app/images/upload_images_screen.dart';
import 'package:app_note/screens/app/note_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        '/note_screen': (context) => NoteScreen(),
        '/images_screen': (context) => const ImagesScreen(),
        '/upload_images_screen': (context) => const UploadImagesScren(),
      };

  ThemeData get themData => ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(bodyMedium: GoogleFonts.poppins()),
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

  void showLoading({required String message, bool error = false}) {
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF000000).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 150,
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index.isEven ? Colors.white : Colors.white,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(message,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void showAwesomeDialog({required String message, bool error = false}){
        AwesomeDialog(
          context: this,
          dialogType: DialogType.warning,
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
          width: 350,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Warning',
          desc: message,
          showCloseIcon: true,
          /*btnCancelOnPress: () {},*/
          btnOkOnPress: () {},
          btnOkColor: Colors.lightBlue
        ).show();

  }
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

  AppLocalizations get localizations {
    return AppLocalizations.of(this)!;
  }
}
