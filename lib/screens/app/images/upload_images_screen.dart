

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    ? ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                            minWidth: double.infinity),
                        child: IconButton(
                            onPressed: () => _showBottomSheet(context),
                            icon: const Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.black,
                            )))
                    : InkWell(
                        onTap: () => _showBottomSheet(context),
                        child: Image.file(File(_choosePickedImage!.path)))),
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

  void openGallery() async{
    XFile? fileImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(fileImage !=null){
      setState(() {
        _choosePickedImage = fileImage;
      });
    }
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.only(topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)),
      ),
      clipBehavior: Clip.antiAlias,
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {
          },
          builder: (context) {
            return Container(
              color: Colors.white,
              height: 180,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Please Choose Image',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blueGrey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        openGallery();
                        Navigator.pop(context);
                      },                      child: Row(
                        children: const[
                          Expanded(
                              flex: 1,
                              child: Icon(Icons.image,color: Colors.black45,)
                          ),
                          Expanded(
                            flex: 4,
                            child: Text('From Gallery',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.blueGrey),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: (){
                        openComer();
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const[
                          Expanded(
                              flex: 1,
                              child: Icon(Icons.camera,color: Colors.black45,)
                          ),
                          Expanded(
                            flex: 4,
                            child: Text('From Camera',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.blueGrey),),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

          },
        );
      },
    );
  }

}
