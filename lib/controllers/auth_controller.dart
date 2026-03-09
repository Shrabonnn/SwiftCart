import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/auth/login_screen.dart';
import '../view/home/home_screen.dart';

class AuthController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController fullNameTEController = TextEditingController();
  final TextEditingController addressTEController = TextEditingController();
  final TextEditingController phoneNumberTEController = TextEditingController();
  RxString fullName = ''.obs;


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

  Future<void> loadProfile() async {
    String? email = _auth.currentUser?.email;
    if (email != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(email).get();
      if (doc.exists) {
        fullName.value = doc['full_name'] ?? 'User';

      }
    }
  }

  void profileSetup()async{


    try{
      indicator.value = true;


      final token = await FirebaseMessaging.instance.getToken();

      String? email = FirebaseAuth.instance.currentUser?.email;

      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'email': email,
        'full_name': fullNameTEController.text,
        'address': addressTEController.text,
        'phone_number': phoneNumberTEController.text,
        'token': token,
      });
      fullName.value = fullNameTEController.text;
      indicator.value =false;
      Get.offAll(()=> const HomeScreen());
    }catch(e){
      indicator.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  void clear(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}