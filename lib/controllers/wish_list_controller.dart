import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  var wishlist = <String>[].obs;


  final user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  // void toggleWishlist(product) {
  //   if (wishlist.contains(product)) {
  //     wishlist.remove(product);
  //   } else {
  //     wishlist.add(product);
  //   }
  // }
  //
  // bool isExist(product) {
  //   return wishlist.contains(product);
  // }

  void loadWishlist() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('wishlist')
        .get();

    wishlist.value = snapshot.docs.map((doc) => doc.id).toList();
  }

  void toggleWishlist(QueryDocumentSnapshot<Map<String, dynamic>> product) async {
    final productId = product.id;

    if (wishlist.contains(productId)) {
      // remove from local
      wishlist.remove(productId);

      // remove from firebase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.email)
          .collection('wishlist')
          .doc(productId)
          .delete();
    } else {
      // add local
      wishlist.add(productId);

      // add to firebase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.email)
          .collection('wishlist')
          .doc(productId)
          .set({
        'productId': productId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  bool isExist(product) {
    return wishlist.contains(product.id);
  }
}
