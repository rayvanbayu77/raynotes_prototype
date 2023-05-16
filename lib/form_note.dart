import 'package:flutter/material.dart';
import 'package:note_rev/database/db_helper.dart';
import 'model/note.dart';

class FormNote extends StatefulWidget {
  final Note? note;
  FormNote({this.note});

  @override
  _FormNoteState createState() => _FormNoteState();
}

class _FormNoteState extends State<FormNote> {
  DbHelper db = DbHelper();

  TextEditingController? judul;
  TextEditingController? konten;

  @override
  void initState() {
    judul = TextEditingController(
        text: widget.note == null ? '' : widget.note!.judul);
    konten = TextEditingController(
        text: widget.note == null ? '' : widget.note!.konten);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Note'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: judul,
              decoration: InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: konten,
              decoration: InputDecoration(
                  labelText: 'Konten',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.note == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertNote();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertNote() async {
    if (widget.note != null) {
      await db.updateNote(Note.fromMap({
        'id': widget.note!.id,
        'judul': judul!.text,
        'konten': konten!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      await db.saveNote(Note(
        judul: judul!.text,
        konten: konten!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
