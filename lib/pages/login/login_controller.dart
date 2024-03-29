import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/firebase/firebase_authentication.dart';
import 'package:todo_app/pages/login/login_view.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/pages/todo_list/todo_list_view.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  validateEmailAndPassword() {
    if (emailController.text.isEmpty) {
      u.showWarning("Warning", "Please Enter email id");
      return true;
    } else if (passwordController.text.isEmpty) {
      u.showWarning("Warning", "Please Enter password");
      return true;
    } else if (passwordController.text.length < 6) {
      u.showWarning("Warning", "Please give password Atleast 6 characters");
      return true;
    } else {
      return false;
    }
  }

  onLogin() {
    if (validateEmailAndPassword()) {
      return;
    }

    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((user) {});
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  onLogout() {
    clearCredentials();
    FirebaseAuth.instance.signOut();
  }

  createNewUser() async {
    validateEmailAndPassword();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((user) {
        // if (user == null) {
        //   Get.offAll(() => TodoListView());
        // } else {}
        print(user);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  checkUserLoggedInOrNot() {
    validateEmailAndPassword();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAll(() => const LoginView());
      } else {
        g.userMail = user.email!;
        final todoController = Get.find<TodoListController>();
        todoController.searchByToday();
        todoController.getTodos();
        Get.offAll(() => TodoListView());
      }
    });
  }

  clearCredentials() {
    emailController.text = "";
    passwordController.text = "";
  }
}
