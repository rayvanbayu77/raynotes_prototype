import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'form_note.dart';
import 'package:note_rev/model/note.dart';

class ListNotePage extends StatefulWidget {
  const ListNotePage({Key? key}) : super(key: key);

  @override
  _ListNotePageState createState() => _ListNotePageState();
}

class _ListNotePageState extends State<ListNotePage> {
  List<Note> listNote = [];
  DbHelper db = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RayNotes"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('profilepages'),
              title: Text('Profile'),
              leading: CircleAvatar(
                child: Icon(Icons.apps),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: listNote.length,
        itemBuilder: (context, index) {
          Note note = listNote[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              title: Text('${note.judul}'),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text("${note.konten}"),
                  ),
                ],
              ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _openFormEdit(note);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        AlertDialog hapus = AlertDialog(
                          title: Text("Konfirmasi"),
                          content: Container(
                            height: 100,
                            child: Column(
                              children: [
                                Text("Yakin ingin menghapus ${note.judul} ")
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  _deleteNote(note, index);
                                  Navigator.pop(context);
                                },
                                child: Text("Ya")),
                            TextButton(
                              child: Text('Tidak'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                        showDialog(
                            context: context, builder: (context) => hapus);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllNote() async {
    var list = await db.getAllNote();

    setState(() {
      listNote.clear();
      list!.forEach((note) {
        listNote.add(Note.fromMap(note));
      });
    });
  }

  Future<void> _deleteNote(Note note, int position) async {
    await db.deleteNote(note.id!);
    setState(() {
      listNote.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormNote()));
    if (result == 'save') {
      await _getAllNote();
    }
  }

  Future<void> _openFormEdit(Note note) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormNote(note: note)));
    if (result == 'update') {
      await _getAllNote();
    }
  }
}
