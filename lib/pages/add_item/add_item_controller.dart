import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/firebase/firebase_database.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/utils.dart' as u;

class AddItemController extends GetxController {
  var isSelectedTodo = true.obs;
  var selectedDate = DateTime.now().obs;
  var goingToMakePriority = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  storeDataToDb() async {
    TodoModel tooData = TodoModel.fromJson({});
    tooData.type = isSelectedTodo.value == true ? "todo" : "routine";
    tooData.title = titleController.text;
    tooData.description = descriptionController.text;
    tooData.dateTime = selectedDate.value.toString();
    tooData.priority = goingToMakePriority.value;

    dynamic response = await FirebaseDatabase().storeData(
        tooData,
        DateTime(selectedDate.value.year, selectedDate.value.month,
                selectedDate.value.day)
            .millisecondsSinceEpoch
            .toString());
    print(response);
    if (response == null) {
      clearData();
    }
  }

  validate() {
    if (titleController.text.isEmpty) {
      u.showWarning("!", "Please give title for your todo.");
      return false;
    } else if (descriptionController.text.isEmpty) {
      u.showWarning("!", "Please give description");
      return false;
    } else {
      return true;
    }
  }

  clearData() {
    goingToMakePriority.value = false;
    selectedDate.value = DateTime.now();
    titleController.clear();
    descriptionController.clear();
  }
}
