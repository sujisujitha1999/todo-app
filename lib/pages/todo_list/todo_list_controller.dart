import 'package:get/get.dart';
import 'package:todo_app/model/todo_model.dart';
import '../../firebase/firebase_database.dart';

class TodoListController extends GetxController {
  var isGettingTodos = false.obs;
  var todoList = <TodoModel>[].obs;

  getTodos() async {
    isGettingTodos.value = true;
    todoList.value = await FirebaseDatabase().readData();
    isGettingTodos.value = false;
    update();
  }
}
