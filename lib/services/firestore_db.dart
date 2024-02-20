// import 'package:cloud_firestore/cloud_firestore.dart';

// class FireDB {
//   createNewNoteFirestore(gmail, id) async {
//     await getAllStoredNotes(gmail);
//     await FirebaseFirestore.instance
//         .collection("notes")
//         .doc(gmail)
//         .collection("usernotes")
//         .doc(id)
//         .set({
//       "title": "this is a new title",
//       "content": "this is a new content",
//       "created_at": DateTime.now(),
//     }).then((_) {
//       print("data added successfully");
//     });
//   }

//   getAllStoredNotes(String gmail) async {
//     await FirebaseFirestore.instance
//         .collection("notes")
//         .doc(gmail)
//         .collection("usernotes")
//         .orderBy("date")
//         .get()
//         .then((querySnapshot) {
//       querySnapshot.docs.forEach((result) {
//         print(result.data());
//       });
//     });
//   }
// }
