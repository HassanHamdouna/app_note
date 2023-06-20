import 'package:app_note/models/fb_response.dart';
import 'package:app_note/models/note.dart';
import 'package:app_note/utils/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreController with FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FbResponse> create(Note note) async {
    return _firestore
        .collection('Notes')
        .add(note.toMap())
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }

  Future<FbResponse> update(Note note) async {
    return _firestore
        .collection('Notes')
        .doc(note.id)
        .update(note.toMap())
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }

  Future<FbResponse> delete(String id) {
    return _firestore
        .collection('Notes')
        .doc(id)
        .delete()
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }

  // Stream<QuerySnapshot<Map<String,dynamic>>> read() async*{
  //   yield* _firestore.collection('Notes').snapshots();
  // }

  Stream<QuerySnapshot<Note>> read() async* {
    yield* _firestore
        .collection('Notes')
        .withConverter<Note>(
          fromFirestore: (snapshot, options) => Note.fromMap(snapshot.data()!),
          toFirestore: (Note value, options) => value.toMap(),
        )
        .snapshots();
  }
}
