import 'package:app_note/models/fb_response.dart';
import 'package:app_note/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FbResponse> create(Note note) async {
    return _firestore
        .collection('Notes')
        .add(note.toMap())
        .then((value) => FbResponse('Operation completed successfully', true))
        .catchError((error) => FbResponse('Operation failed', false));
  }
}
