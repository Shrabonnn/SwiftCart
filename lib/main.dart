import 'package:ecommerce/bindings/bindings.dart';
import 'package:ecommerce/splash_screen.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/utils/app_theme_data.dart';
import 'package:ecommerce/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Ecommerce());
}
class Ecommerce extends StatefulWidget  {

  const Ecommerce({super.key});

  @override
  State<Ecommerce> createState() => _EcommerceState();
}

class _EcommerceState extends State<Ecommerce> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBindings(),
      home:FirebaseAuth.instance.currentUser !=null? const HomeScreen() :SplashScreen(),
      theme: AppThemeData(),
    );
  }


}
