import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';import '../../utils/app_colors.dart';


import '../../widgets/custom_button.dart';
import '../../widgets/custom_title_widgets.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
final TextEditingController _fullNameTEController = TextEditingController();
final TextEditingController _addressTEController = TextEditingController();
final TextEditingController _phoneNumberTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class _ProfileScreenState extends State<ProfileScreen> {
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
                  CustomTitleWidgets(title: 'Profile Setup', subtitle: ''),
                  Text('Please fill be below details to complete your profile.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                  SizedBox(height: 16,),
                  _buildProfilePhoto(),
                  SizedBox(height: 30,),

                  _buildForm(),
                  SizedBox(height: 32,),

                  //sign In button
                  CustomButton(title: 'Complete Setup', onTap: (){
                    if(_formKey.currentState!.validate()){

                    }
                  }),
                  SizedBox(height: 32,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildProfilePhoto() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2,
            ),
            image: const DecorationImage(
              image: NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/002/534/006/small/social-media-chatting-online-blank-profile-picture-head-and-body-icon-people-standing-icon-grey-background-free-vector.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.camera_alt,
            color: AppColors.primaryColor,
            size: 20,
          ),
        )
      ],
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
          controller: _fullNameTEController,
          decoration: InputDecoration(
            hintText: 'Full Name',
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
          controller: _addressTEController,
          decoration: InputDecoration(
            hintText: 'Address',
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
          controller: _phoneNumberTEController,
          decoration: InputDecoration(
            hintText: 'Phone Number',
          ),
        ),
      ],
    );
  }
}
