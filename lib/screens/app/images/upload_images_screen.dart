

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadImagesScren extends StatefulWidget {
  const UploadImagesScren({super.key});

  @override
  State<UploadImagesScren> createState() => _UploadImagesScrenState();
}

class _UploadImagesScrenState extends State<UploadImagesScren> {
  // File? _image;
  // final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Upload',),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            Expanded(child: Container()),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.cloud_upload_rounded),
                label: const Text('upload'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40.h),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),

    );
  }
}
