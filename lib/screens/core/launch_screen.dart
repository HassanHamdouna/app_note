import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}



class _LaunchScreenState extends State<LaunchScreen> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed( const Duration(seconds: 3) , (){
      Navigator.pushReplacementNamed(context, "/login_screen");
      // Navigator.pushReplacementNamed(context, "/register_screen");
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('Firebase', style: GoogleFonts.arefRuqaa(
          color: Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
