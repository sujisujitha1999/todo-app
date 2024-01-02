import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/add_item_controller.dart';
import 'package:todo_app/constant.dart';
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: violet,
            width: w * .1,
            child: SafeArea(
              child: Column(
                children: [
                  vFill(h * .02),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    width: double.infinity,
                    height: h * .2,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: DmsansText(
                          text: "All",
                          color: violet,
                          weight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  vFill(4),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    width: double.infinity,
                    height: h * .2,
                    decoration: BoxDecoration(
                        color: todoColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        // turns: AlwaysStoppedAnimation(360 / 360),
                        child: DmsansText(
                          text: "Todo",
                          color: violet,
                          weight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  vFill(4),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    width: double.infinity,
                    height: h * .2,
                    decoration: BoxDecoration(
                        color: routinecolor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        // turns: AlwaysStoppedAnimation(360 / 360),
                        child: DmsansText(
                          text: "Routine",
                          color: violet,
                          weight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: w * .9,
            child: TodoList(h: h, today: today, w: w),
          )
        ],
      ),
      floatingActionButton: SizedBox(
          height: h * .15,
          width: w * .18,
          child: FloatingActionButton(
              backgroundColor: violet,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AddItemScreen(
                      h: h,
                      w: w,
                    );
                  },
                );
              },
              child: Text(
                String.fromCharCode(CupertinoIcons.add.codePoint),
                style: TextStyle(
                    // inherit: false,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w100,
                    fontFamily: CupertinoIcons.add.fontFamily,
                    package: CupertinoIcons.add.fontPackage),
              ))),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
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
              vFill(h * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DmsansText(
                    text: "Calendar",
                    fontSize: 18,
                    color: violet,
                  ),
                  hFill(2),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: violet,
                  )
                ],
              ),
              vFill(h * .04),
              DmsansText(
                text: "${getMonthName(today)} ${today.year}",
                color: violet,
                fontSize: 16,
                weight: FontWeight.w600,
              ),
              DmsansText(
                  text: "${today.day} ${getWeekDay(today)}",
                  color: violet,
                  fontSize: 40,
                  weight: FontWeight.w900),
              vFill(h * .01),
              Stack(
                children: [
                  Container(
                      height: 2,
                      width: w,
                      color: const Color.fromARGB(255, 129, 114, 169)),
                  Container(
                    height: 2,
                    width: w * .3,
                    color: violet,
                  )
                ],
              ),
              vFill(h * .02),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
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
                            value: true,
                            onChanged: (value) {},
                          ),
                        ),
                        hFill(10),
                        DmsansText(
                          text: "Send the first draft design",
                          fontSize: 17,
                          weight: FontWeight.w500,
                          color: violet,
                        ),
                        const Spacer(),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                              color: Color(0xff97b7c0), shape: BoxShape.circle),
                        ),
                        // Icon(Icons.label_important_rounded)
                      ],
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

class AddItemScreen extends GetView<AddItemController> {
  const AddItemScreen({super.key, required this.h, required this.w});
  final double h;
  final double w;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * .05),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: DmsansText(
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
                  // padding: EdgeInsets.symmetric(vertical: 10),
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
                                  border:
                                      Border.all(color: Colors.black, width: 1),
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
                                    shape: BoxShape.circle, color: todoColor),
                              ),
                              hFill(10),
                              const DmsansText(
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
                                  border:
                                      Border.all(color: Colors.black, width: 1),
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
                              const DmsansText(
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
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none)),
            ),
            vFill(h * .02),
            getHeading("Description"),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none)),
            ),
            vFill(h * .02),
            getHeading("Date"),
            InkWell(
              onTap: () async {
                controller.selectedDate.value = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
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
                      child: DmsansText(
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
                const DmsansText(
                  text: "Show it on the top of Todo list",
                  fontSize: 17,
                  color: Colors.black45,
                ),
                Transform.scale(
                    scale: 2.0,
                    child: Obx(
                      () => Checkbox(
                          activeColor: violet,
                          side:
                              const BorderSide(color: Colors.black, width: 0.5),
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
                      Get.back();
                    },
                    child: const DmsansText(
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
    );
  }
}

getHeading(String str) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DmsansText(
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
          child: DmsansText(
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
            child: DmsansText(text: getMonthName(DateTime(2023, i, 12))))));
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
            child: DmsansText(
          text: i.toString(),
        ))));
  }
  return months;
}
