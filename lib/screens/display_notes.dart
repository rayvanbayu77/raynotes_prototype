import 'package:flutter/material.dart';
import 'package:raynotes/db/database_provider.dart';
import 'package:raynotes/model/note_model.dart';
import 'package:raynotes/screens/add_note.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context).settings.arguments as NoteModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Note"),
        actions: [
          IconButton(
            onPressed: () {
              updateNote(note);
            },
            icon: Icon(Icons.edit)
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              DatabaseProvider.db.deleteNote(note.id);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              note.title,
              style:
                  const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              note.body,
              style: const TextStyle(fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }
}
