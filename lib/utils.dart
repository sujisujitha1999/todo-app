import 'package:flutter/material.dart';
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

class DmsansText extends StatelessWidget {
  const DmsansText(
      {super.key, required this.text, this.color, this.weight, this.fontSize});
  final String text;
  final Color? color;
  final FontWeight? weight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        color: color,
        fontSize: fontSize,
        fontWeight: weight,
      ),
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
