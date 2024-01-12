import 'package:get/get.dart';

class AddItemController extends GetxController {
  var isSelectedTodo = true.obs;
  var selectedDate = DateTime.now().obs;
  var goingToMakePriority = false.obs;
}
