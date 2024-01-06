import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/utils.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
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
