import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/images.dart';

class ProductDeatilsScreen extends StatefulWidget {
  const ProductDeatilsScreen({super.key});

  @override
  State<ProductDeatilsScreen> createState() => _ProductDeatilsScreenState();
}

class _ProductDeatilsScreenState extends State<ProductDeatilsScreen> {

  int selectedSizeIndex = -1;

  @override
  Widget build(BuildContext context) {

    List<int> sizeAvialable =[35,36,37,38,39,40];

    // int selectedSizeIndex = -1; here doesn't work bcz setsate rebuild korle -1 hoye jay i
    final size = MediaQuery.sizeOf(context);


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: size.height * .3,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: AppColors.cartBackground,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(child: Image.asset(ImagePath.product,)),
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Apple Watch Series 6',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orangeAccent),
                              Icon(Icons.star, color: Colors.orangeAccent),
                              Icon(Icons.star, color: Colors.orangeAccent),
                              Icon(Icons.star, color: Colors.orangeAccent),
                              Icon(Icons.star, color: Colors.orangeAccent),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\$500 discount_price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Available in stock',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'About',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            'The upgraded S6 SiP runs up to 20 percent faster, allowing apps to also launch 20 percent faster, while maintaining the same all-day 18-hour battery life.',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


            SizedBox(height: 16,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for(int i in sizeAvialable)
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedSizeIndex = i;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 55,
                        width: 55,
                        decoration:BoxDecoration(
                            color: selectedSizeIndex == i ? AppColors.primaryColor: AppColors.cartBackground,
                            borderRadius: BorderRadius.circular(8)
                        ) ,
                        child: Center(child: Text("$i",style: TextStyle(fontSize: 20,color:selectedSizeIndex == i? Colors.white : Colors.black,fontWeight: FontWeight.w400),)),
                      ),
                    )

                ],
              ),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(title: "Add to cart", onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
