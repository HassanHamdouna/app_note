import 'dart:io';

import 'package:app_note/models/fb_response.dart';
import 'package:app_note/utils/firebase_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FbStorageController with FirebaseHelper{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  /// function :
  ///1) upload
  ///2) Delete
  ///3) Read

 UploadTask upload(String path){
    UploadTask uploadTask = _storage
        .ref('images/${DateTime.now().millisecond}')
        .putFile(File(path));
    return uploadTask;
  }

  Future<List<Reference>> read() async {
    ListResult result = await _storage.ref('image').listAll();
    if (result.items.isNotEmpty) {
      return result.items;
    }
    return [];
  }

  Future<FbResponse> delete(String path) async {
    return _storage
        .ref(path)
        .delete()
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }
}