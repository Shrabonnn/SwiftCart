import 'package:ecommerce/view/auth/login_screen.dart';
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
final TextEditingController _emaiTEController = TextEditingController();
final TextEditingController _passwordTEController = TextEditingController();
final TextEditingController _confirmPasswordTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _RegisterScreenState extends State<RegisterScreen> {
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

                  //sign In button
                  CustomButton(title: 'Sign up', onTap: (){
                    if(_formKey.currentState!.validate()){

                    }
                  }),
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
          controller: _emaiTEController,
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
          controller: _passwordTEController,
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
            return null;
          },
          obscureText: true,
          controller: _confirmPasswordTEController,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
          ),
        ),
      ],
    );
  }
}
