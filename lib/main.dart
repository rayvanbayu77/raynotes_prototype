// ignore_for_file: missing_return, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raynotes/db/database_provider.dart';
import 'package:raynotes/model/note_model.dart';
import 'package:raynotes/screens/add_note.dart';
import 'package:raynotes/screens/display_notes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/AddNote": (context) => AddNote(),
        "/ShowNote": (context) => ShowNote(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RayNotes"),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, noteData) {
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
            case ConnectionState.done:
              {
                if (noteData.data == Null) {
                  return Center(
                    child: Text("You don't have any notes, create one!"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: noteData.data.length,
                      itemBuilder: (context, index) {
                        String title = noteData.data[index]['title'];
                        String body = noteData.data[index]['body'];
                        String creationDate =
                            noteData.data[index]['creation_date'];
                        int id = noteData.data[index]['id'];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/ShowNote", arguments: NoteModel(
                                title: title,
                                body: body,
                                creation_date: 
                                DateTime.parse(creationDate),
                                id: id,
                              ));  
                            },
                            title: Text(title),
                            subtitle: Text(body),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddNote");
        },
        child: Icon(Icons.note_add),
      ),
    );
  }
}
