
import 'package:flutter/material.dart';
import 'package:raynotes/db/database_provider.dart';
import 'package:raynotes/model/note_model.dart';

class AddNote extends StatefulWidget {
  AddNote({Key key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;
  String body;
  DateTime date;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
    print("Note Succesfully Added");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Your Note",
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            date = DateTime.now();
          });
          NoteModel note =
              NoteModel(title: title, body: body, creation_date: date);
          addNote(note);
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        label: Text("Save Note"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
