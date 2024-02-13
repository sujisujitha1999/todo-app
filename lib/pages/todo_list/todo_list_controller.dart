import 'package:get/get.dart';
import 'package:todo_app/model/todo_model.dart';
import '../../firebase/firebase_database.dart';

class TodoListController extends GetxController {
  var isGettingTodos = false.obs;
  var todoList = <TodoModel>[].obs;
  String searchFromRange = "";
  String searchToRange = "";

  searchByToday() {
    DateTime today = DateTime.now();
    searchFromRange = DateTime(today.year, today.month, today.day)
        .microsecondsSinceEpoch
        .toString();
    searchToRange = DateTime(today.year, today.month, today.day)
        .add(const Duration(days: 1))
        .microsecondsSinceEpoch
        .toString();
  }

  getTodos() async {
    isGettingTodos.value = true;

    todoList.value =
        await FirebaseDatabase().readData(searchFromRange, searchToRange);
    isGettingTodos.value = false;
    update();
  }
}
