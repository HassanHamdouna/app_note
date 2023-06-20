import 'package:app_note/firebase/fb_auth_controller.dart';
import 'package:app_note/firebase/fb_fire_store_controller.dart';
import 'package:app_note/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const  Text('Home Screen'),
        actions: [
          IconButton(onPressed: () async{
            FbAuthController().signOut();
            Navigator.pushReplacementNamed(context, '/login_screen');
            }, icon: const Icon(Icons.login)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Note>>(
        stream: FbFireStoreController().read(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
              return const ListTile(leading: Icon(Icons.note_add),
              title: Text(''),
              subtitle: Text(''),
              trailing: Icon(Icons.delete,color: Colors.red),);
            },);
          } else{
            return const Center(child: Text('no data',),);
          }
        },
      ),
    );
  }
}
