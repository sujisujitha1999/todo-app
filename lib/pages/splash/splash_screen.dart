import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/utils.dart' as u;

import '../todo_list/todo_list_controller.dart';
import '../todo_list/todo_list_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      Get.find<TodoListController>().getTodos();
      Get.offAll(
        () => TodoListView(),
      );
    });
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: violet,
      body: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * .5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: u.TextWithDmSans(
                    text: "MY",
                    fontSize: 50,
                    weight: FontWeight.w800,
                    color: todoColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: width * .53,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: u.TextWithDmSans(
                    text: "TODO",
                    fontSize: 50,
                    weight: FontWeight.w800,
                    color: routinecolor,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
          u.vFill(20),
        ],
      ),
    );
  }
}
