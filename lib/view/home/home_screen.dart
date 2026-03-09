import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/view/cart/cart_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_sigle_product_screen.dart';
import '../auth/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


final controller = Get.put(AuthController());
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {

    // Data are comming through Firebase as listformate
    List<String> sliders = [
      'https://img.freepik.com/free-psd/black-friday-super-sale-facebook-cover-banner-template_120329-5177.jpg?semt=ais_hybrid&w=740&q=80',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZksh69EFuBvwmFbrHA7AAsEZANKol-vXL25rxrV_V2eRPiUeWLW9Qw7c&s',
      'https://img.freepik.com/free-vector/gradient-shopping-discount-horizontal-sale-banner_23-2150321996.jpg?semt=ais_hybrid&w=740&q=80',
      'https://cdn3.f-cdn.com//files/download/186511390/big%20sale%201.jpg?width=780&height=438&fit=crop',
    ];

    List<String> categories =[
      'assets/images/1.png',
      'assets/images/2.png',
      'assets/images/3.png',
      'assets/images/4.png',
      'assets/images/5.png',
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          // Cart Section
          IconButton(
            onPressed: () {
              Get.to(CartListScreen());
            },
            icon: Icon(Icons.shopping_cart),
          ),

          //Profile Section
          IconButton(onPressed: () {
            Get.to(ProfileScreen());
          }, icon: Icon(Icons.person),),
        ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Obx(()=>Text(
                 'Welcome \"${controller.fullName.value}"',
                 style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.w700,
                   fontSize: 20,
                 ),
               ),),
              Text(
                'Let’s start shopping!',
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildCarouselSlider(sliders),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    scrollDirection:Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context ,index){
                      return Container(
                        margin: EdgeInsetsGeometry.all(5),
                        width: 80,
                        decoration: BoxDecoration(
                          color: AppColors.cartBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black.withOpacity(.1),
                            width: 1.5,
                          ),
                        ),
                        child: Image.asset(categories[index]),
                      );
                    }),
              ),
              const SizedBox(height: 20,),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  //childAspectRatio: .9
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return CustomSigleProductGrid();
                },
              )
            ],
          ),
        ),
      ),

    );
  }

  CarouselSlider _buildCarouselSlider(List<String> sliders) {
    return CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(sliders[itemIndex]),fit: BoxFit.cover),
                    ),
                  ),
              options: CarouselOptions(
                  height: 150,
                  autoPlay: true,
                  enlargeFactor: 0.3,
                  enlargeCenterPage: true
              ),
            );
  }
}
