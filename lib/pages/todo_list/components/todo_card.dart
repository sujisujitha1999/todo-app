import 'dart:math';

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
    return Container(
      height: h * .83,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(45), topLeft: Radius.circular(45))),
      child: Padding(
        padding: EdgeInsets.only(top: h * .03),
        child: Column(
          children: [
            SizedBox(
              height: h * .08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < 3; i++)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        u.TextWithDmSans(
                          text: i == 0 ? "All" : (i == 1 ? "Todo" : "Routine"),
                          weight: FontWeight.w700,
                          fontSize: 18,
                          color: violet,
                        ),
                        // Text()
                        Container(
                          color: violet,
                          height: 2,
                          width: 30,
                        )
                      ],
                    )
                ],
              ),
            ),
            SizedBox(
              height: h * .72,
              child: GetBuilder<TodoListController>(builder: (cont) {
                return controller.isGettingTodos.value
                    ? const Center(child: CircularProgressIndicator())
                    : TodoList(
                        controller: controller,
                        w: w,
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeAndCalendarHeader extends StatelessWidget {
  const TimeAndCalendarHeader({
    super.key,
    required this.h,
    required this.today,
  });

  final double h;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            u.TextWithDmSans(
              text: "${u.getMonthName(today)} ${today.year}",
              color: Colors.white,
              fontSize: 16,
              weight: FontWeight.w600,
            ),
            u.TextWithDmSans(
                text: "${today.day} ${u.getWeekDay(today)}",
                // color: darkGreen,
                color: Colors.white,
                fontSize: 40,
                weight: FontWeight.w900),
          ],
        ),
        Spacer(),
        u.TextWithDmSans(
          text: "Calendar",
          fontSize: 18,
          color: Colors.white,
        ),
        u.hFill(2),
        Icon(
          Icons.arrow_forward_rounded,
          // color: darkGreen,
          color: Colors.white,
        )
      ],
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.controller,
    required this.w,
  });

  final TodoListController controller;
  final double w;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.todoList.length,
      itemBuilder: (BuildContext context, int index) {
        return
            // InkWell(
            // onTap: () => showTaskDetails(w, controller, index),
            // child:
            Container(
          margin: EdgeInsets.only(bottom: 5, left: w * .02, right: w * .02),
          padding:
              const EdgeInsets.only(top: 25, bottom: 25, right: 20, left: 10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: violet, width: 0.2)
          ),
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
                  value: controller.todoList[index].status ?? false,
                  onChanged: (value) {
                    controller.showConfirmStatus(
                        controller.todoList[index], value!);
                  },
                ),
              ),
              u.hFill(10),
              SizedBox(
                width: w * .76,
                child: u.TextWithDmSans(
                  text: controller.todoList[index].title ?? "--",
                  fontSize: 17,
                  weight: FontWeight.w500,
                  decoration: controller.todoList[index].status!
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: violet,
                ),
              ),
              const Spacer(),
            ],
          ),
        );
        // );
      },
    );
  }
}
