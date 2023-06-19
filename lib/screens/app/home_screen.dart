import 'package:app_note/firebase/fb_auth_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const  Text('Home Screen'),
        actions: [
          IconButton(onPressed: () async{
            FbAuthController().signOut();
            Navigator.pushReplacementNamed(context, '/login_screen');
            }, icon: const Icon(Icons.login)),
        ],
      ),
    );
  }
}
