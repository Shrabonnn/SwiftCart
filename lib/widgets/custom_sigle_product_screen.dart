import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view/productDetails/product_deatils_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';


class CustomSigleProductGrid extends StatelessWidget {
  const CustomSigleProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(ProductDeatilsScreen());
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.cartBackground,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset('assets/images/product1.png'),
                Text("Redmi Note 4",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$200',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$500',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                )
              ],
            ),
            // Discount
            Positioned(
              top: 2,
              left: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("50% Discount",style: TextStyle(fontSize: 10)),
              ),
            ),
            // Favorite icon
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    shape: BoxShape.circle
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.favorite_border, size: 18),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
