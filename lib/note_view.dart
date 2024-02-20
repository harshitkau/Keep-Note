import 'package:flutter/material.dart';
import 'package:keep_note/archiv.dart';
import 'package:keep_note/color.dart';
import 'package:keep_note/edit_note_view.dart';
import 'package:keep_note/home.dart';
import 'package:keep_note/services/db.dart';
import 'package:intl/intl.dart';

import 'model/my_note_model.dart';

class NoteView extends StatefulWidget {
  Note note;
  NoteView({required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
            splashRadius: 17,
            onPressed: () async {
              await NotesDatabase.instance.pinNote(widget.note);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(
                widget.note.pin ? Icons.push_pin : Icons.push_pin_outlined),
          ),
          IconButton(
            splashRadius: 17,
            onPressed: () async {
              await NotesDatabase.instance.archNote(widget.note);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ArchiveView()));
            },
            icon: Icon(
                widget.note.isArchive ? Icons.archive : Icons.archive_outlined),
          ),
          IconButton(
            splashRadius: 17,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditNoteView(note: widget.note)));
            },
            icon: Icon(Icons.edit_outlined),
          ),
          IconButton(
            splashRadius: 17,
            onPressed: () async {
              await NotesDatabase.instance.deleteNotes(widget.note);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(Icons.delete_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Created On ${DateFormat('dd-MM-yyyy - kk:mm').format(widget.note.createdTime)}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(
                widget.note.title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(height: 15),
              Text(
                widget.note.content,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
