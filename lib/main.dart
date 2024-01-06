import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/add_item/add_item_controller.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/todo_list/todo_list_view.dart';
import 'package:todo_app/utils.dart';

void main() {
  Get.put(AddItemController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListView(),
    );
  }
}
