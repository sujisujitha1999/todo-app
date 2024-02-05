// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/utils.dart' as u;

class FirebaseDatabase {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<List<TodoModel>> readData() async {
    final collectionReference =
        await database.collection("sujisujitha1999@gmail.com").get();
    List<TodoModel> list =
        collectionReference.docs.map((e) => TodoModel.fromSnapshot(e)).toList();
    return list;
  }

  storeData(TodoModel data, String id) async {
    CollectionReference reference =
        database.collection("sujisujitha1999@gmail.com");
    await reference
        .add(data.toJson())
        .whenComplete(
            () => u.showWarning("Success", "Successfully added your todo."))
        .catchError((error, stackTrace) {
      u.showWarning("Error", "Something went wrong. Try again");
    });
  }
}
