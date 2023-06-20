import 'package:app_note/firebase/fb_store_controller.dart';
import 'package:app_note/utils/context_extenssion.dart';
import 'package:flutter/material.dart';

import '../../models/note.dart';
import '../../widgets/app_text_field.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key, this.note});

  Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleTextController;
  late TextEditingController _infoTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController = TextEditingController(text: widget.note?.title);
    _infoTextController = TextEditingController(text: widget.note?.info);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextController.dispose();
    _infoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(_isNewNote ?'create':'update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your information:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _titleTextController,
              keyboardType: TextInputType.text,
              prefixIcon: Icons.text_fields,
              hint: 'Title',
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: _infoTextController,
              keyboardType: TextInputType.text,
              prefixIcon: Icons.info,
              hint: 'Info',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                // Background color of the button
                foregroundColor: Colors.white,
                // Text color of the button
                padding: const EdgeInsets.all(16),
                // Padding around the button's child
                elevation: 4,
                // Elevation of the button
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Border radius of the button
                ),
              ),
              onPressed: () => _pref(),
              child:  Text(_isNewNote ?'create':'update'),
            ),
          ],
        ),
      ),
    );
  }

  bool get _isNewNote => widget.note == null;

  void _pref() {
    if (_checkData()) {
      _save();
    }
  }

  bool _checkData() {
    if (_infoTextController.text.isNotEmpty &&
        _titleTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Input is empty!', error: false);
    return false;
  }

  void _save() async {
    _isNewNote
        ? await FbStoreController().create(note)
        : await FbStoreController().update(note);
    Navigator.pop(context);
  }

  Note get note {
    Note note = _isNewNote ? Note() : widget.note!;
    note.title = _titleTextController.text.toString();
    note.info = _infoTextController.text.toString();
    return note;
  }
}
