
import 'package:app_note/firebase/fb_auth_controller.dart';
import 'package:app_note/firebase/fb_store_controller.dart';
import 'package:app_note/models/fb_response.dart';
import 'package:app_note/models/note.dart';
import 'package:app_note/utils/context_extenssion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: ()  {
                Navigator.pushReplacementNamed(context, '/note_screen');
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                FbAuthController().signOut();
                Navigator.pushReplacementNamed(context, '/login_screen');
              },
              icon: const Icon(Icons.login)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Note>>(
        stream: FbStoreController().read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NoteScreen(note: getNote(snapshot.data!.docs[index])),)
                      );
                    } ,
                    leading: const Icon(Icons.note_add),
                    title: Text(snapshot.data!.docs[index].data().title),
                    subtitle: Text(snapshot.data!.docs[index].data().info),
                    trailing: IconButton(
                      onPressed: () => _delete(context, snapshot.data!.docs[index].id),
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ));
              },
            );
          } else {
            return const Center(
              child: Text(
                'no data',
              ),
            );
          }
        },
      ),
    );
  }

  void _delete(BuildContext context,String id) async{
   FbResponse fbResponse = await FbStoreController().delete(id);
   context.showSnackBar(message: fbResponse.message,error: !fbResponse.success);
  }

  Note getNote(QueryDocumentSnapshot<Note> queryNote){
    Note note = Note();
    note.id = queryNote.id;
    note.title = queryNote.data().title;
    note.info = queryNote.data().info;
    return note;
  }
}
