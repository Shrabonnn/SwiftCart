import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/product_controller.dart';
import '../../utils/app_colors.dart';

class ProductDeatilsScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> product;

  ProductDeatilsScreen({super.key, required this.product});

  final ProductController productController = Get.put(ProductController());
  final HomeController homecontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Product Image and Info
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        color: AppColors.cartBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Image.network(product['image'],
                        fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: List.generate(
                                5,
                                    (index) => Icon(Icons.star,
                                    color: Colors.orangeAccent)),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${product['discount_price']== "" ? product['original_price']: product['discount_price']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                'Available in stock',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'About',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                          SizedBox(height: 8),
                          Text(
                            product['about'] ?? '',
                            style:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Size Selector from Firestore
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('products').doc(product.id).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (!snapshot.hasData || snapshot.data!.data() == null) {
                    return const Text("No sizes available");
                  }

                  // keep sizes as strings
                  List<String> sizes = List<String>.from(snapshot.data!.data()!['sizes'] ?? []);

                  return SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sizes.length,
                      itemBuilder: (context, index) {
                        String sizeValue = sizes[index];
                        return Obx(
                              () => InkWell(
                            onTap: () {
                              productController.selectedIndex.value = index;
                              productController.selectedSize.value = sizeValue;
                            },
                            child: Container(
                              width: 40,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: productController.selectedIndex.value == index
                                    ? AppColors.primaryColor
                                    : AppColors.cartBackground,
                                border: Border.all(color: Colors.black.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  sizeValue,
                                  style: TextStyle(
                                    color: productController.selectedIndex.value == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                title: "Add to cart",
                onTap: () {
                  productController.addToCart(product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}