import 'package:flutter/material.dart';
import 'package:keep_note/color.dart';
import 'package:keep_note/home.dart';
import 'package:keep_note/note_view.dart';
import 'package:keep_note/services/db.dart';

import 'model/my_note_model.dart';

class EditNoteView extends StatefulWidget {
  Note note;
  EditNoteView({required this.note});
  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late String NewTitle;
  late String NewNoteDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.NewTitle = widget.note.title.toString();
    this.NewNoteDetail = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              Note newNote = Note(
                  title: NewTitle,
                  content: NewNoteDetail,
                  pin: widget.note.pin,
                  isArchive: widget.note.isArchive,
                  createdTime: widget.note.createdTime,
                  id: widget.note.id);
              await NotesDatabase.instance.updateNotes(newNote);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
              // Navigator.pop(context);
            },
            icon: Icon(Icons.save_outlined),
            splashRadius: 17,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                initialValue: NewTitle,
                cursorColor: white,
                onChanged: (value) {
                  NewTitle = value;
                },
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.8))),
              ),
            ),
            Container(
              height: 300,
              child: Form(
                child: TextFormField(
                  initialValue: NewNoteDetail,
                  cursorColor: white,
                  onChanged: (value) {
                    NewNoteDetail = value;
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 50,
                  maxLines: null,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Note",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.8))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
