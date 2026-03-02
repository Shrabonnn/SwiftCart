import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view/auth/register_screen.dart';
import 'package:ecommerce/view/auth/profile_screen.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_title_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

 final TextEditingController _emaiTEController = TextEditingController();
 final TextEditingController _passwordTEController = TextEditingController();
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class _LoginScreenState extends State<LoginScreen> {
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
                  CustomTitleWidgets(title: 'Login here', subtitle: ''),
                  Text('Welcome back you\'ve \nbeen missed!',
                    textAlign: TextAlign.center,
                      style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                  SizedBox(height: 80,),
                  _buildForm(),
                  SizedBox(height: 24,),

                  //forgot password button
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){}, child: Text('Forgot your password?',style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  ),
                  SizedBox(height: 24,),

                  //sign In button
                  CustomButton(title: 'Sign in', onTap: (){
                    //if(_formKey.currentState!.validate()){}
                    Get.to(ProfileScreen());
                  }),
                  SizedBox(height: 32,),

                  //create new account button
                  TextButton(onPressed: (){
                    Get.off(RegisterScreen());

                  }, child: Text('Create new account',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),))

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
      ],
    );
  }
}
