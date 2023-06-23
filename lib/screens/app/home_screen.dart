import 'package:app_note/firebase/fb_auth_controller.dart';
import 'package:app_note/firebase/fb_store_controller.dart';
import 'package:app_note/models/fb_response.dart';
import 'package:app_note/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(onPressed: ()=> Navigator.pushNamed(context, '/images_screen'), icon: const Icon(Icons.image_outlined)),
          IconButton(
              onPressed: () async {
                FbAuthController().signOut();
                Navigator.pushReplacementNamed(context, '/login_screen');
              },
              icon: const Icon(Icons.login)),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              StreamBuilder<QuerySnapshot<Note>>(
                stream: FbStoreController().read(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        /// library flutter_slidable
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => {
                                  _delete(
                                      context, snapshot.data!.docs[index].id),
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                              SlidableAction(
                                onPressed: (context) => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NoteScreen(
                                            note: getNote(
                                                snapshot.data!.docs[index])),
                                      )),
                                },
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.edit_note_outlined,
                                label: 'edite',
                              ),
                            ],
                          ),
                          child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NoteScreen(
                                          note: getNote(
                                              snapshot.data!.docs[index])),
                                    ));
                              },
                              leading: const Icon(Icons.note_add),
                              title:
                                  Text(snapshot.data!.docs[index].data().title),
                              subtitle:
                                  Text(snapshot.data!.docs[index].data().info),
                              trailing: IconButton(
                                onPressed: (){},
                                icon: const Icon(Icons.image,
                                    color: Colors.lightBlue),
                              )),
                        );
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
            ],
          ),
          Positioned(
              bottom: 50,
              right: 30,
              child: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, '/note_screen'),
                child: const Icon(Icons.add, size: 30, color: Colors.white),
              ))
        ],
      ),
    );
  }

  void _delete(BuildContext context, String id) async {
    FbResponse fbResponse = await FbStoreController().delete(id);
    // context.showSnackBar(message: fbResponse.message, error: !fbResponse.success);
  }

  Note getNote(QueryDocumentSnapshot<Note> queryNote) {
    Note note = Note();
    note.id = queryNote.id;
    note.title = queryNote.data().title;
    note.info = queryNote.data().info;
    return note;
  }
}
