import 'package:get/get.dart';

class WishListController extends GetxController{
  var wishlist = [].obs;

  void toggleWishlist(product) {
    if (wishlist.contains(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }
  }

  bool isExist(product) {
    return wishlist.contains(product);
  }
}
