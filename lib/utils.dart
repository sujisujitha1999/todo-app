import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

Logger log = Logger();
String getWeekDay(DateTime day) {
  return DateFormat.E().format(day);
}

String getMonthName(DateTime day) {
  return DateFormat("MMMM").format(day);
}

String getFullDate(DateTime day) {
  return DateFormat.yMMMMEEEEd().format(day);
}

class TextWithDmSans extends StatelessWidget {
  const TextWithDmSans(
      {super.key,
      required this.text,
      this.color,
      this.weight,
      this.fontSize,
      this.decoration});
  final String text;
  final Color? color;
  final FontWeight? weight;
  final double? fontSize;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
          color: color,
          fontSize: fontSize,
          fontWeight: weight,
          decoration: decoration),
    );
  }
}

hFill(double size) {
  return SizedBox(
    width: size,
  );
}

vFill(double size) {
  return SizedBox(
    height: size,
  );
}

bool isLoading = false;
showLoading(message) {
  isLoading = true;
  showDialog(
    context: Get.overlayContext!,
    barrierDismissible: false,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: SizedBox(
          width: 300,
          // height: 100,
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  strokeWidth: 5,
                  // valueColor: AlwaysStoppedAnimation<Color>(),
                ),
                vFill(10),
                Text('$message...',
                    style: const TextStyle(fontSize: 20, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

closeLoading() {
  if (isLoading) {
    isLoading = false;
    Navigator.of(Get.overlayContext!).pop();
  }
}

showWarning(String title, String msg) {
  Get.snackbar(title, msg,
      titleText: Row(
        children: const [
          Icon(
            Icons.warning_rounded,
            color: Colors.orange,
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.amber.shade50,
      colorText: Colors.orange);
}

List<BoxShadow> getBoxShadow() {
  return const [
    BoxShadow(
      color: Colors.black38,
      offset: Offset(
        0,
        4,
      ),
      blurRadius: 10,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ),
  ];
}
