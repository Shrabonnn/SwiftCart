import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view/auth/login_screen.dart';
import 'package:ecommerce/view/auth/register_screen.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_title_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/images.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(ImagePath.welcomeScreenImg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTitleWidgets(title: 'Discover Your Dream Job here', subtitle: 'Explore all the existing job roles based on your interest and study major'),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: CustomButton(title: 'Login', onTap: (){
                  Get.to(LoginScreen());
                },isLoading:false )),
                SizedBox(width: 16,),
                Expanded(child: CustomButton(title: 'Register',isLoading: false,backgroundColor: Colors.transparent,titleColor: Colors.red, onTap: (){
                  Get.to(RegisterScreen());
                }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
