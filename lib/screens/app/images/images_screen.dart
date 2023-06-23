import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(' images ',),
        actions: [
          IconButton(onPressed: ()=> Navigator.pushNamed(context, '/upload_images_screen'), icon: const Icon(Icons.camera_alt))
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h,),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
