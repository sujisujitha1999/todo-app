import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/utils.dart' as u;
import '../todo_list_controller.dart';

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
      height: h,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(45), topLeft: Radius.circular(45))),
      child: Padding(
        padding: EdgeInsets.only(top: h * .03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: controller.isCalendarOpened.value ? 60 : h * .07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: controller.isCalendarOpened.value
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          u.TextWithDmSans(
                            text:
                                i == 0 ? "All" : (i == 1 ? "Todo" : "Routine"),
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
              GetBuilder<TodoListController>(builder: (cont) {
                return controller.isGettingTodos.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: violet,
                      ))
                    : TodoList(
                        controller: controller,
                        w: w,
                        h: h,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.controller,
    required this.w,
    required this.h,
  });

  final TodoListController controller;
  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return controller.todoList.isEmpty
        ? SizedBox(
            height: h * .5,
            child: const Center(
                child: u.TextWithDmSans(
              text: "There are no Todos here",
              fontSize: 17,
              weight: FontWeight.w500,
            )),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    EdgeInsets.only(bottom: 5, left: w * .02, right: w * .02),
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, right: 20, left: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
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
            },
          );
  }
}
