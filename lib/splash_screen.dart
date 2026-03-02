import 'dart:async';

import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      Get.off(WelcomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SwiftCart',style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),),
            Text('Click. Cart. Done.',style: TextStyle(
                fontSize: 18,
                color: Colors.white
            ),),
          ],
        ),
      ),
    );
  }
}
