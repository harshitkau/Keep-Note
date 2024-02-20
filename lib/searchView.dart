import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep_note/color.dart';
import 'package:keep_note/services/db.dart';

import 'model/my_note_model.dart';
import 'note_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<int> SearchResultIDs = [];
  List<Note?> SearchResultNotes = [];
  bool isLoading = false;

  void SearchResult(String query) async {
    SearchResultNotes.clear();
    setState(() {
      isLoading = true;
    });
    final ResultId = await NotesDatabase.instance.getNoteString(query);
    List<Note?> SearchResultNotesLocal = [];

    ResultId.forEach((element) async {
      final SearchNote = await NotesDatabase.instance.readOneNote(element);
      SearchResultNotesLocal.add(SearchNote);
      setState(() {
        SearchResultNotes.add(SearchNote);
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: white,
                          )),
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search Your Notes",
                            hintStyle: TextStyle(
                              color: white.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                          onSubmitted: (value) {
                            setState(() {
                              SearchResult(value.toLowerCase());
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  isLoading
                      ? Container(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white)),
                        )
                      : NoteSectionAll(),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget NoteSectionAll() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              children: [
                Text(
                  "Search Results",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height - 266 - 133,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: MasonryGridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  itemCount: SearchResultNotes.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteView(
                                      note: SearchResultNotes[index]!,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SearchResultNotes[index]!.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              SearchResultNotes[index]!.content.length > 250
                                  ? "${SearchResultNotes[index]!.content.substring(0, 250)}..."
                                  : SearchResultNotes[index]!.content,
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
          ),
        ],
      ),
    );
  }
}
