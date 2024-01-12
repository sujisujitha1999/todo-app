import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/firebase/firebase_database.dart';
import 'package:todo_app/utils.dart';

import 'components/todo_card.dart';

class TodoListView extends StatelessWidget {
  TodoListView({super.key});
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
            child: TodoCard(h: h, today: today, w: w),
          )
        ],
      ),
      floatingActionButton: SizedBox(
          height: h * .15,
          width: w * .18,
          child: FloatingActionButton(
              backgroundColor: violet,
              onPressed: () async {
                FirebaseDatabase firebase = FirebaseDatabase();
                Map? todoList = await firebase.readData();
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
