import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxList<String> sliders = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBanner();
  }

  getBanner()async{
    final data = await FirebaseFirestore.instance.collection('banners').get();

    for (var element in data.docs){
      print(element.data()['data']);
      print('sssssss');
      sliders.add(element.data()['data']);

    }
  }
}