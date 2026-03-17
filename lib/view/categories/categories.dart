import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_sigle_product_grid.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.category});

  final QueryDocumentSnapshot<Map<String, dynamic>> category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category['name'],style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 24
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder(stream: FirebaseFirestore.instance.collection('products').where('category_id',isEqualTo: category['id']).snapshots(), builder: (context,snapshot){

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No products found"));
              }

              var products = snapshot.data!.docs;

              return GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  //childAspectRatio: .9
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {

                  final product = snapshot.data!.docs[index];
                  return CustomSigleProductGrid(product: product,);
                },
              );

            })
          ],
        ),
      ),
    );
  }
}
