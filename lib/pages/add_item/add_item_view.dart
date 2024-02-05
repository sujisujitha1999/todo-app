import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart';

class AddItemScreen extends GetView<AddItemController> {
  const AddItemScreen({super.key, required this.h, required this.w});
  final double h;
  final double w;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .05),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: TextWithDmSans(
                    text: "Add",
                    color: Colors.black,
                    fontSize: 35,
                    weight: FontWeight.w700,
                  ),
                ),
                vFill(h * .01),
                Center(
                  child: Container(
                    width: 50,
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                vFill(h * .03),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: h * .08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.grey.shade300)),
                      width: w * .9,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.isSelectedTodo.value = true;
                            },
                            child: Container(
                              decoration: controller.isSelectedTodo.value
                                  ? BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(7),
                                    )
                                  : null,
                              height: h * .08,
                              width: w * .45,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: todoColor),
                                  ),
                                  hFill(10),
                                  const TextWithDmSans(
                                    text: "Todo",
                                    fontSize: 17,
                                    weight: FontWeight.w500,
                                  ),
                                ],
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.isSelectedTodo.value = false;
                            },
                            child: Container(
                              decoration: !controller.isSelectedTodo.value
                                  ? BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(7),
                                    )
                                  : null,
                              height: h * .08,
                              width: w * .45,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: routinecolor),
                                  ),
                                  hFill(10),
                                  const TextWithDmSans(
                                    text: "Routine",
                                    fontSize: 17,
                                    weight: FontWeight.w500,
                                  ),
                                ],
                              )),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                vFill(h * .03),
                getHeading("Title"),
                TextFormField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none)),
                ),
                vFill(h * .02),
                getHeading("Description"),
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none)),
                ),
                vFill(h * .02),
                getHeading("Date"),
                InkWell(
                  onTap: () async {
                    controller.selectedDate.value = await showDatePicker(
                            context: context,
                            initialDate: controller.selectedDate.value,
                            firstDate: DateTime(2023, 01, 01),
                            lastDate: DateTime(2050, 01, 01)) ??
                        controller.selectedDate.value;
                  },
                  child: Obx(
                    () => Container(
                      height: h * .08,
                      width: w * .9,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(7)),
                      child: Center(
                          child: TextWithDmSans(
                              text: getFullDate(controller.selectedDate.value),
                              fontSize: 17,
                              weight: FontWeight.w500)),
                    ),
                  ),
                ),
                vFill(h * .02),
                getHeading("Priority"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWithDmSans(
                      text: "Show it on the top of Todo list",
                      fontSize: 17,
                      color: Colors.black45,
                    ),
                    Transform.scale(
                        scale: 2.0,
                        child: Obx(
                          () => Checkbox(
                              activeColor: violet,
                              side: const BorderSide(
                                  color: Colors.black, width: 0.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: controller.goingToMakePriority.value,
                              onChanged: (bool? val) {
                                controller.goingToMakePriority.value = val!;
                              }),
                        ))
                  ],
                ),
                vFill(h * .02),
                Center(
                  child: SizedBox(
                    width: w * .8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: violet,
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                            shadowColor: violet),
                        onPressed: () {
                          // if (controller.validate()) {
                          controller.storeDataToDb();
                          // }
                        },
                        child: const TextWithDmSans(
                          text: "Save",
                          fontSize: 17,
                          weight: FontWeight.w500,
                        )),
                  ),
                ),
                vFill(h * .02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getHeading(String str) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextWithDmSans(
        text: str,
        fontSize: 17,
        weight: FontWeight.w500,
      ),
      vFill(7),
      Container(
        height: 2,
        width: 20,
        color: Colors.black45,
      ),
      vFill(10),
    ],
  );
}

getDays(h, w) {
  List<Widget> days = [];
  for (int i = 1; i <= 31; i++) {
    days.add(SizedBox(
      width: w * .2,
      height: h * .08,
      child: Center(
          child: TextWithDmSans(
        text: i.toString(),
        fontSize: 20,
        weight: FontWeight.w500,
      )),
    ));
  }
  return days;
}

getMonths(h, w) {
  List<Widget> months = [];
  for (int i = 1; i <= 12; i++) {
    months.add(SizedBox(
        height: h * .08,
        width: w * .5,
        child: Center(
            child: TextWithDmSans(text: getMonthName(DateTime(2023, i, 12))))));
  }
  return months;
}

getYears(h, w) {
  List<Widget> months = [];
  for (int i = 1999; i <= 2050; i++) {
    months.add(SizedBox(
        height: h * .08,
        width: w * .5,
        child: Center(
            child: TextWithDmSans(
          text: i.toString(),
        ))));
  }
  return months;
}
