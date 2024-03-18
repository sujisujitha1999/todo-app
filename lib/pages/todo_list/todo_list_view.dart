import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/utils.dart';
import 'components/floating_button.dart';
import 'components/time_with_calendar_header.dart';
import 'components/todo_card.dart';
import 'package:todo_app/utils.dart' as u;

class TodoListView extends GetView<TodoListController> {
  TodoListView({super.key});
  final DateTime today = DateTime.now();
  // Map? data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          BgContainer(w: w, h: h, today: today),
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Obx(() => TodoListContainer(
                  h: controller.isCalendarOpened.value ? h * .2 : h * .87,
                  today: today,
                  w: w)))
        ],
      ),
      floatingActionButton: FloatingWidget(h: h, w: w),
    );
  }
}

class BgContainer extends GetView<TodoListController> {
  const BgContainer({
    super.key,
    required this.w,
    required this.h,
    required this.today,
  });

  final double w;
  final double h;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * .02),
      height: h,
      width: w,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [violetLight, violet])),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            u.vFill(h * .02),
            SafeArea(
              child: TimeAndCalendarHeader(h: h, today: today),
            ),
            u.vFill(h * .04),
            GetBuilder<TodoListController>(builder: (cont) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.closeCalendar();
                            },
                            icon: const Icon(
                              Icons.close,
                            ))
                      ],
                    ),
                    TableCalendar(
                      focusedDay: controller.selectedDate.value,
                      firstDay: DateTime(2024, 03, 04),
                      lastDay: DateTime.now().add(
                        const Duration(days: 100),
                      ),
                      selectedDayPredicate: (day) {
                        return isSameDay(day, controller.selectedDate.value);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        controller.selectDate(selectedDay);
                      },
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        decoration: BoxDecoration(),
                      ),
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: GoogleFonts.dmSans(
                              color: violet, fontWeight: FontWeight.w600)),
                      calendarStyle: const CalendarStyle(
                        outsideDaysVisible: false,
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          return calenderDaysBox(day);
                        },
                        selectedBuilder: (context, day, focusedDay) =>
                            calenderDaysBox(day,
                                gradient: LinearGradient(
                                    colors: [violetLight, violet]),
                                dayColor: Colors.white,
                                weight: FontWeight.w600),
                        todayBuilder: (context, day, focusedDay) =>
                            calenderDaysBox(day,
                                border: Border.all(color: violet, width: 1.3),
                                dayColor: violet,
                                weight: FontWeight.w600),
                        outsideBuilder: (context, day, focusedDay) =>
                            const SizedBox(),
                        disabledBuilder: (context, day, focusedDay) =>
                            calenderDaysBox(day, dayColor: Colors.grey),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

calenderDaysBox(DateTime day,
    {LinearGradient? gradient,
    Color dayColor = Colors.black,
    FontWeight weight = FontWeight.w400,
    BoxBorder? border}) {
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.circle, gradient: gradient, border: border),
    height: 40,
    width: 40,
    child: Center(
        child: u.TextWithDmSans(
      text: day.day.toString(),
      color: dayColor,
      weight: weight,
    )),
  );
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

bgWhiteContainer(Widget child) {
  return Container(
    color: Colors.white,
    child: child,
  );
}
