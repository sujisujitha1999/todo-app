import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;

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
                  child: u.TextWithDmSans(
                    text: "Add",
                    color: Colors.black,
                    fontSize: 35,
                    weight: FontWeight.w700,
                  ),
                ),
                u.vFill(h * .01),
                Center(
                  child: Container(
                    width: 50,
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                // vFill(h * .02),

                /*  Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: h * .08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(color: Colors.blue.withOpacity(0.2))),
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
                                          color: violet.withOpacity(0.7),
                                          width: 1),
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
                                          color: violet.withOpacity(0.7),
                                          width: 1),
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
                ),*/
                u.vFill(h * .03),
                getHeading("Title"),
                TextFormField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue.withOpacity(0.1),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none)),
                ),
                u.vFill(h * .02),
                getHeading("Description"),
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      filled: true,
                      // fillColor: Colors.grey.shade200,
                      fillColor: Colors.blue.withOpacity(0.1),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none)),
                ),
                u.vFill(h * .02),
                getHeading("Date"),
                TapCalendarWidet(
                  controller: controller,
                  h: h,
                  w: w,
                ),
                u.vFill(h * .02),
                getHeading("Collab with"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    g.collabUsers.isEmpty
                        ? const u.TextWithDmSans(
                            text: "There is no collabers added yet")
                        : DropdownButton(
                            value: "prathi",
                            items: g.collabUsers
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: u.TextWithDmSans(
                                      text: e,
                                    )))
                                .toList(),
                            onChanged: (value) {},
                          ),
                    IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Add collabrator",
                              content: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    u.TextWithDmSans(
                                      text: "Name",
                                      weight: FontWeight.w500,
                                    ),
                                    u.vFill(10),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Collaborator Name",
                                          hintStyle:
                                              GoogleFonts.dmSans(fontSize: 12),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: violet,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: violet)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: violet))),
                                    ),
                                    u.vFill(20),
                                    u.TextWithDmSans(
                                      text: "Email",
                                      weight: FontWeight.w500,
                                    ),
                                    u.vFill(10),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Collaborator Email",
                                          hintStyle:
                                              GoogleFonts.dmSans(fontSize: 12),
                                          prefixIcon: Icon(
                                            Icons.mail_rounded,
                                            color: violet,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: violet)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: violet))),
                                    ),
                                    u.vFill(20),
                                  ],
                                ),
                              ),
                              actions: [
                                SizedBox(
                                  width: w * .3,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      onPressed: () {
                                        // controller.sendEmail();
                                      },
                                      child: u.TextWithDmSans(
                                        text: "Add",
                                        weight: FontWeight.w500,
                                      )),
                                )
                              ]);
                        },
                        icon: Icon(
                          Icons.add_circle_rounded,
                          color: Colors.green,
                          size: 40,
                        ))
                  ],
                ),
                u.vFill(h * .02),
                getHeading("Priority"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const u.TextWithDmSans(
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
                u.vFill(h * .02),
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
                        child: const u.TextWithDmSans(
                          text: "Save",
                          fontSize: 17,
                          weight: FontWeight.w500,
                        )),
                  ),
                ),
                u.vFill(h * .02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TapCalendarWidet extends StatelessWidget {
  const TapCalendarWidet({
    super.key,
    required this.controller,
    required this.h,
    required this.w,
  });

  final AddItemController controller;

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          padding: const EdgeInsets.symmetric(vertical: 15),
          // height: h * .08,
          // width: w * .9,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(7)),
          child: Center(
              child: u.TextWithDmSans(
                  text: u.getFullDate(controller.selectedDate.value),
                  fontSize: 17,
                  weight: FontWeight.w500)),
        ),
      ),
    );
  }
}

getHeading(String str) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      u.TextWithDmSans(
        text: str,
        fontSize: 17,
        weight: FontWeight.w500,
      ),
      u.vFill(7),
      Container(
        height: 2,
        width: 20,
        color: Colors.black45,
      ),
      u.vFill(10),
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
          child: u.TextWithDmSans(
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
            child: u.TextWithDmSans(
                text: u.getMonthName(DateTime(2023, i, 12))))));
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
            child: u.TextWithDmSans(
          text: i.toString(),
        ))));
  }
  return months;
}
