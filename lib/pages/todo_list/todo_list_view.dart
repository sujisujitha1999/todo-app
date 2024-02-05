import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/utils.dart';

import '../add_item/add_item_view.dart';
import 'components/todo_card.dart';

class TodoListView extends GetView<TodoListController> {
  TodoListView({super.key});
  final DateTime today = DateTime.now();
  // Map? data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GetBuilder<TodoListController>(builder: (cont) {
        return controller.isGettingTodos.value
            ? const Center(child: CircularProgressIndicator())
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: violet,
                    width: w * .1,
                    child: SafeArea(
                      child: Column(
                        children: [
                          vFill(h * .02),
                          SideButton(
                            h: h,
                            text: "ALL",
                            textColor: violet,
                            backgroundColor: Colors.white,
                          ),
                          vFill(4),
                          SideButton(
                              h: h,
                              text: "Todo",
                              textColor: violet,
                              backgroundColor: todoColor),
                          vFill(4),
                          SideButton(
                              h: h,
                              text: "Routine",
                              textColor: violet,
                              backgroundColor: routinecolor)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w * .9,
                    child: TodoContainer(h: h, today: today, w: w * .9),
                  )
                ],
              );
      }),
      floatingActionButton: SizedBox(
          height: h * .15,
          width: w * .18,
          child: FloatingActionButton(
              backgroundColor: violet,
              onPressed: () async {
                Get.to(() => AddItemScreen(
                      w: w,
                      h: h,
                    ));
              },
              child: Text(
                String.fromCharCode(CupertinoIcons.add.codePoint),
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w100,
                    fontFamily: CupertinoIcons.add.fontFamily,
                    package: CupertinoIcons.add.fontPackage),
              ))),
    );
  }
}

class SideButton extends StatelessWidget {
  const SideButton({
    super.key,
    required this.h,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  final double h;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 2),
      width: double.infinity,
      height: h * .2,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: TextWithDmSans(
            text: text,
            color: textColor,
            weight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
