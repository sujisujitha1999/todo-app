import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/utils.dart' as u;

import '../todo_list_controller.dart';

class TodoContainer extends GetView<TodoListController> {
  const TodoContainer({
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Get.dialog(Material(
                      type: MaterialType.transparency,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    width: w * .8,
                                    decoration: BoxDecoration(
                                        color:
                                            controller.todoList[index].type ==
                                                    "todo"
                                                ? todoColor
                                                : routinecolor),
                                    child: Center(
                                      child: Row(children: [
                                        Spacer(),
                                        u.TextWithDmSans(
                                          text: controller
                                                  .todoList[index].title ??
                                              "--",
                                          fontSize: 15,
                                          weight: FontWeight.w500,
                                        ),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: Icon(Icons.close))
                                      ]),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    width: w * .8,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Column(
                                      children: [
                                        u.TextWithDmSans(
                                            text: controller.todoList[index]
                                                    .description ??
                                                "-..."),
                                        u.vFill(10),
                                        Row(
                                          children: [
                                            u.TextWithDmSans(
                                              text: "Date:   ",
                                            ),
                                            u.TextWithDmSans(
                                              text:
                                                  u.getFullDate(DateTime.now()),
                                              weight: FontWeight.w500,
                                            )
                                          ],
                                        ),
                                        u.vFill(10),
                                        Row(
                                          children: [
                                            u.TextWithDmSans(
                                              text: "Time:   ",
                                            ),
                                            u.TextWithDmSans(
                                              text:
                                                  u.getFullDate(DateTime.now()),
                                              weight: FontWeight.w500,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )),
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 25, bottom: 25, right: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200))),
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
                                icon: Icon(Icons.delete,
                                    color: Colors.red.shade400)),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
