import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCart();

  }

  final user = FirebaseAuth.instance.currentUser;

  var cart = <QueryDocumentSnapshot>[].obs;
  RxBool isLoading = true.obs;

  RxDouble totalPrice = 0.0.obs;

  getCart() async{

    await FirebaseFirestore.instance.collection('users').doc(user!.email).collection('cart').snapshots().listen((snapshot){
      print(snapshot.docs.length);
      isLoading.value = false;
      // cart.add(firebaseCart)

      cart.value =snapshot.docs;
      calculateTotal();
    });
  }

  calculateTotal() {
    double total = 0.0;

    for (var item in cart) {
      double price = double.tryParse(item['price']) ?? 0;
      int quantity = item['quantity']; // quantity already number

      total += price * quantity;
    }

    totalPrice.value = total;
  }

  // when click the buy now button it remove all the cart
  removecart() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('cart')
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }

    cart.clear();
    totalPrice.value = 0.0;
  }



}