import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/wish_list_controller.dart';
import '../../widgets/custom_sigle_product_grid.dart';

class WishListScreen extends StatelessWidget {
  WishListScreen({super.key});

  final WishListController wishListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wishlist")),
      body: Obx((){
        if (wishListController.wishlist.isEmpty) {
          return Center(child: Text("Your wishlist is empty"));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(stream: FirebaseFirestore.instance.collection('products').snapshots(), builder: (context,snapshot){
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
              itemCount: wishListController.wishlist.length,
              itemBuilder: (context, index) {

                var product = wishListController.wishlist[index];
                return CustomSigleProductGrid(product: product,);
              },
            );
          }),
        );
      })
    );
  }
}