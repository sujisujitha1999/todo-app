// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/utils.dart' as u;

class FirebaseDatabase {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<Map?> readData() async {
    DocumentSnapshot documentSnapshot = await database
        .collection("todos")
        .doc("sujisujitha1999@gmail.com")
        .get();
    u.log.d(documentSnapshot.data());
    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map;
    } else {
      return null;
    }
  }
}
