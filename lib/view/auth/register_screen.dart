import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/view/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_title_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24,),
                  CustomTitleWidgets(title: 'Create Account', subtitle: ''),
                  Text('Create an account so you can explore all the existing jobs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                  SizedBox(height: 80,),
                  _buildForm(),
                  SizedBox(height: 32,),

                  Obx(()=>CustomButton(title: 'Sign up', onTap: () {
                    if (_formKey.currentState!.validate()) {
                      controller.signup();
                    }
                  }, isLoading: controller.indicator.value),),

                  SizedBox(height: 32,),

                  //already have an account
                  TextButton(onPressed: (){

                    Get.off(LoginScreen());
                  }, child: Text('Already have an account',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildForm() {
    return Column(
      children: [
        TextFormField(
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Enter a valid Email";
            }
            return null;
          },
          controller: controller.emailController,
          decoration: InputDecoration(
            hintText: 'Email',
          ),
        ),
        SizedBox(height: 24,),
        TextFormField(
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Enter a valid Password";
            }
            return null;
          },
          obscureText: true,
          controller: controller.passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
          ),
        ),
        SizedBox(height: 24,),
        TextFormField(
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Enter a Password again";
            }
            if (value != controller.passwordController.text) {
              return "Password does not match";
            }
            return null;
          },
          obscureText: true,
          controller: controller.confirmPasswordController,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
          ),
        ),
      ],
    );
  }
}
