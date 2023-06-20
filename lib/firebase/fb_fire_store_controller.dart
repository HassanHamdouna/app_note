import 'package:app_note/models/fb_response.dart';
import 'package:app_note/models/note.dart';
import 'package:app_note/utils/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreController with FirebaseHelper{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FbResponse> create(Note note) async {
    return _firestore
        .collection('Notes')
        .add(note.toMap())
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }
}
