import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/firebase/firebase_authentication.dart';
import 'package:todo_app/pages/login/login_view.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/pages/todo_list/todo_list_view.dart';
import 'package:todo_app/utils.dart' as u;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  validateEmailAndPassword() {
    if (emailController.text.isEmpty) {
      u.showWarning("Warning", "Please Enter email id");
      return;
    } else if (passwordController.text.isEmpty) {
      u.showWarning("Warning", "Please Enter password");
    } else if (passwordController.text.length < 6) {
      u.showWarning("Warning", "Please give password Atleast 6 characters");
      return;
    }
  }

  onLogin() {
    validateEmailAndPassword();
    FirebaseAuthentication()
        .createNewUser(emailController.text, passwordController.text)
        .then((value) {
      if (value == null) {
        print("Logged in successfully.");
        Get.offAll(() => HomeView());
      } else {
        print(value);
      }
    });
  }

  checkUserLoggedInOrNot() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAll(() => LoginView());
      } else {
        Get.find<TodoListController>().getTodos();
        Get.offAll(() => HomeView());
      }
    });
  }
}
