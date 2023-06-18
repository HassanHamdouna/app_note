import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.hint,
    required this.prefixIcon,
    required this.keyboardType,
    required this.controller,
    this.focusedBorderColor = Colors.grey,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  final String hint;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Color focusedBorderColor;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.cairo(fontSize: 13.sp),
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hint,
        hintStyle: GoogleFonts.cairo(fontSize: 13.sp),
        hintMaxLines: 1,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(color: focusedBorderColor),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: color),
    );
  }
}
