import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/images.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/product_inc_dec_button.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

final user = FirebaseAuth.instance.currentUser;

class _CartListScreenState extends State<CartListScreen> {
  @override
  Widget build(BuildContext context) {

    final cartController = Get.find<CartController>();


    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.off(HomeScreen());
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(()=>  Expanded(
              child: ListView.builder(
                  itemCount: cartController.cart.length,
                  itemBuilder: (context,index){

                    final product = cartController.cart[index];
                    return _buildCartListItem(product);
                  }),
            ),),
            Obx(()=> Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text(
                    cartController.totalPrice.value.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(title: "Buy Now", onTap: () {
                cartController.removecart();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartListItem(product) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          height: 120,
          width: 375,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent,
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(3, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 110,
                  decoration: BoxDecoration(
                    color: AppColors.fieldBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(product['image'],fit: BoxFit.cover,),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "\$${product['price']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Size: ${product['variant']}", style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 6),


                    ProductQuantityIncDecButton(
                      quantity: product['quantity'],
                      onChange: (newQuantity) {
                        // Update Firestore , change quantity
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.email)
                            .collection('cart')
                            .doc(product.id)
                            .update({"quantity": newQuantity});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
