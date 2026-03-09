import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/auth/login_screen.dart';
import '../view/home/home_screen.dart';

class AuthController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool indicator = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login(){

      indicator.value = true;

      _auth.signInWithEmailAndPassword(email: emailController.value.text, password: passwordController.value.text).then((onValue){
        indicator.value= false;
        clear();
        Get.to(HomeScreen());

      }).onError((error, stackTrace){
        indicator.value= false;

        Get.snackbar(
          "Login Failed",
          error.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      },);
  }

  void signup() {
    indicator.value = true;
    _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString(),
        )
        .then((onValue) {
          indicator.value = false;
          clear();
          Get.off(() => LoginScreen());
        })
        .onError((error, stackTrace) {
          indicator.value = false;
          Get.snackbar(
            "Sign up Failed",
            error.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        });

  }

  void clear(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}