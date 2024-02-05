import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/utils.dart' as u;
import '../todo_list_controller.dart';
import 'todo_details_popup.dart';

class TodoListContainer extends GetView<TodoListController> {
  const TodoListContainer({
    super.key,
    required this.h,
    required this.today,
    required this.w,
  });

  final double h;
  final DateTime today;
  final double w;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              u.vFill(h * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  u.TextWithDmSans(
                    text: "Calendar",
                    fontSize: 18,
                    color: violet,
                  ),
                  u.hFill(2),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: violet,
                  )
                ],
              ),
              u.vFill(h * .04),
              u.TextWithDmSans(
                text: "${u.getMonthName(today)} ${today.year}",
                color: violet,
                fontSize: 16,
                weight: FontWeight.w600,
              ),
              u.TextWithDmSans(
                  text: "${today.day} ${u.getWeekDay(today)}",
                  color: violet,
                  fontSize: 40,
                  weight: FontWeight.w900),
              u.vFill(h * .01),
              Container(
                  height: 2,
                  width: w,
                  color: const Color.fromARGB(255, 129, 114, 169)),
              u.vFill(h * .02),
              TodoListView(
                controller: controller,
                w: w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    required this.controller,
    required this.w,
  });

  final TodoListController controller;
  final double w;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.todoList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => showTaskDetails(w, controller, index),
          child: Container(
            padding: const EdgeInsets.only(top: 25, bottom: 25, right: 20),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              children: [
                SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    activeColor: violet,
                    checkColor: Colors.white,
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                u.hFill(10),
                SizedBox(
                  width: w * .6,
                  child: u.TextWithDmSans(
                    text: controller.todoList[index].title ?? "--",
                    fontSize: 17,
                    weight: FontWeight.w500,
                    color: violet,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 24.0,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: Colors.red.shade400)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
