import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_note/create_note_view.dart';
import 'package:keep_note/login.dart';
import 'package:keep_note/note_view.dart';
import 'package:keep_note/searchView.dart';
import 'package:keep_note/services/auth.dart';
import 'package:keep_note/services/db.dart';
import 'package:keep_note/services/firestore_db.dart';
import 'package:keep_note/services/login_info.dart';
import 'package:keep_note/sideMenuBar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'color.dart';
import 'model/my_note_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  late String? imgUrl;
  bool isStaggered = true;
  List<Note> notesList = [];
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  Future createEntry(Note note) async {
    await NotesDatabase.instance.InsertEntry(note);
  }

  Future getAllNotes() async {
    this.notesList = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  Future getOneNotes(int id) async {
    return await NotesDatabase.instance.readOneNote(id);
  }

  Future updateOneNote(Note note) async {
    await NotesDatabase.instance.updateNotes(note);
  }

  Future deleteNote(Note note) async {
    await NotesDatabase.instance.deleteNotes(note);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: bgColor,
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: cardColor,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNoteView()));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 45,
              ),
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _drawerKey,
            drawer: SideMenu(),
            backgroundColor: bgColor,
            body: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {
                  setState(() {});
                });
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3)
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _drawerKey.currentState!.openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      color: white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchView()));
                                    },
                                    child: Container(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width -
                                          162,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Search Your Notes",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: white.withOpacity(0.6),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      white.withOpacity(0.1)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ))),
                                      onPressed: () {
                                        setState(() {
                                          isStaggered = !isStaggered;
                                        });
                                      },
                                      child: Icon(
                                        Icons.grid_view,
                                        color: white,
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     signOut();
                                    //     LocalDataSaver.saveLoginData(false);
                                    //     Navigator.pushReplacement(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => Login()));
                                    //   },
                                    //   child: CircleAvatar(
                                    //     onBackgroundImageError:
                                    //         (Object, StackTrace) {
                                    //       print("Ok");
                                    //     },
                                    //     radius: 16,
                                    //     backgroundImage:
                                    //         NetworkImage(imgUrl.toString()),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        isStaggered ? NoteSectionAll() : NoteListSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget NoteSectionAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                "All",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          // height: 500,
          child: MasonryGridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: notesList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteView(
                                note: notesList[index],
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notesList[index].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        notesList[index].content.length > 250
                            ? "${notesList[index].content.substring(0, 250)}..."
                            : notesList[index].content,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget NoteListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                "All",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          // height: 500,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: notesList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notesList[index].title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      notesList[index].content.length > 250
                          ? "${notesList[index].content.substring(0, 250)}..."
                          : notesList[index].content,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
