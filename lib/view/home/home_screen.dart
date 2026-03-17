import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/splash_screen.dart';
import 'package:ecommerce/view/cart/cart_list_screen.dart';
import 'package:ecommerce/view/categories/categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_sigle_product_grid.dart';
import '../auth/profile_screen.dart';
import '../wish_list_screen/wish_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


final controller = Get.put(AuthController());
final homecontroller = Get.find<HomeController>();
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadProfile();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Swift',style:TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400
            ),),
            Text('Cart',style:TextStyle(
                fontSize: 24,
                color: Colors.black54
            ),),
          ],
        ),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Get.to(ProfileScreen());
        }, icon: Icon(Icons.person)),
        actions: [

          //Profile Section
          IconButton(onPressed: () {
            Get.to(() => WishListScreen());
          }, icon: Icon(Icons.favorite_border),),

          // //Profile Section
          // IconButton(onPressed: () {
          //   Get.to(ProfileScreen());
          // }, icon: Icon(Icons.person),),

          // Cart Section
          IconButton(
            onPressed: () {
              Get.to(CartListScreen());
            },
            icon: Icon(Icons.shopping_cart),
          ),

          //Log out
          IconButton(onPressed: () {

            FirebaseAuth.instance.currentUser == null ;
            Get.offAll(()=> SplashScreen());

          }, icon: Icon(Icons.logout_outlined),),
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
              Obx((){
                if (homecontroller.sliders.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CarouselSlider.builder(
                  itemCount: homecontroller.sliders.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: NetworkImage(homecontroller.sliders[itemIndex]),
                              fit: BoxFit.cover),
                        ),
                      ),
                  options: CarouselOptions(
                      height: 150,
                      autoPlay: true,
                      enlargeFactor: 0.3,
                      enlargeCenterPage: true
                  ),
                );
              },),
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

              //Top Categories
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No categories found"));
                  }

                  return SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        final category = snapshot.data!.docs[index];

                        return GestureDetector(
                          onTap: () {
                            // category wise navigation
                            Get.to(() => Categories(
                              category: category,
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.cartBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black.withOpacity(.1),
                                width: 1.5,
                              ),
                            ),
                            child: Image.network(category['icon']),
                          )
                          );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 20,),
              StreamBuilder(stream: FirebaseFirestore.instance.collection('products').snapshots(), builder: (context,snapshot){
                if(snapshot.connectionState ==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    //childAspectRatio: .9
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {

                    final product = snapshot.data!.docs[index];
                    return CustomSigleProductGrid(product: product,);
                  },
                );
              })
            ],
          ),
        ),
      ),

    );
  }


}
