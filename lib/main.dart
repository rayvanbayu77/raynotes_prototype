import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'profile.dart';
import 'form_note.dart';
import 'list_note.dart';
import 'model/note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'homeview': (context) => ListNotePage(),
        'profilepages': (context) => ProfilePage()
      },
      debugShowCheckedModeBanner: false,
      title: 'RayNotes',
      home: ListNotePage(),
    );
  }
}
