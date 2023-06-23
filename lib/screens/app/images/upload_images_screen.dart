

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagesScren extends StatefulWidget {
  const UploadImagesScren({super.key});

  @override
  State<UploadImagesScren> createState() => _UploadImagesScrenState();
}

class _UploadImagesScrenState extends State<UploadImagesScren> {

  late ImagePicker _imagePicker;
  /// image use choose
  XFile? _choosePickedImage;

  @override
  void initState() {
    // TODO: implement initState
    _imagePicker = ImagePicker();
    super.initState();
  }
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
            Expanded(
                child: _choosePickedImage == null
                ?  IconButton(onPressed: ()=> openComer(), icon: const Icon(Icons.image,size: 20,color: Colors.black,))
                :Image.file(File(_choosePickedImage!.path) )
            ),
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

  void openComer() async{
    XFile? fileImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if(fileImage !=null){
      setState(() {
        _choosePickedImage = fileImage;
      });
    }
  }
}
