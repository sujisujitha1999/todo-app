// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;

class FirebaseDatabase {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<List<TodoModel>> readData(
      String searchFromRange, String searchToRange) async {
    QuerySnapshot<Map<String, dynamic>> collectionReference = await database
        .collection(g.userMail)
        .where(
          FieldPath.documentId,
          isGreaterThanOrEqualTo: searchFromRange,
        )
        .where(FieldPath.documentId, isLessThan: searchToRange)
        .get();

    return collectionReference.docs
        .map((e) => TodoModel.fromSnapshot(e))
        .toList();
  }

  Future storeData(TodoModel data, String id) async {
    await database
        .collection(g.userMail)
        .doc(id)
        .set(data.toJson())
        .whenComplete(() {
      return null;
    }).catchError((error, sta) {
      u.showWarning("Error", "Something went wrong. Try again later.");
      return error;
    });
  }

  Future updateData(
    TodoModel data,
  ) async {
    await database
        .collection(g.userMail)
        .doc(data.id)
        .set(data.toJson())
        .whenComplete(() {
      return null;
    }).catchError((error, sta) {
      u.showWarning("Error", "Something went wrong. Try again later.");
      return error;
    });
  }

  storeCollaborator(Map<String, dynamic> data, String collaboratorEmail,
      {Function()? onSuccess, Function(dynamic)? onError}) async {
    await database
        .collection(g.userMail)
        .doc(collaboratorEmail)
        .set(data)
        .whenComplete(() {
      onSuccess!();
    }).catchError((error, _) {
      u.showWarning("Error", "Something went wrong. Try again later.");
      onError!(error);
    });
  }
}
