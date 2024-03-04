import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/firebase/firebase_database.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/pages/add_item/widgets/success_popup.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/utils.dart' as u;

class AddItemController extends GetxController {
  var isSelectedTodo = true.obs;
  var selectedDate = DateTime.now().obs;
  var goingToMakePriority = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  storeDataToDb() async {
    TodoModel todoData = TodoModel.fromJson({});

    String uniqueId = DateTime(
            selectedDate.value.year,
            selectedDate.value.month,
            selectedDate.value.day,
            DateTime.now().hour,
            DateTime.now().minute,
            DateTime.now().second,
            DateTime.now().millisecond)
        .millisecondsSinceEpoch
        .toString();
    todoData.type = isSelectedTodo.value == true ? "todo" : "routine";
    todoData.title = titleController.text;
    todoData.description = descriptionController.text;
    todoData.dateTime = selectedDate.value.toString();
    todoData.priority = goingToMakePriority.value;
    todoData.id = uniqueId;
    todoData.status = false;
    dynamic response = await FirebaseDatabase().storeData(todoData, uniqueId);
    if (response == null) {
      clearData();

      Get.find<TodoListController>().searchByToday();
      Get.find<TodoListController>().getTodos();
      showSuccessPopup();
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
