import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthBindings extends Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<AuthController>(AuthController());
    Get.put<HomeController>(HomeController());
    Get.put<CartController>(CartController());
  }
}