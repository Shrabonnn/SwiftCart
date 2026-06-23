import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/view/home/home_screen.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../controllers/cart_controller.dart';

class Payment extends StatefulWidget {
  const Payment({super.key, required this.totalbill});

  final double totalbill;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  Map<String, dynamic>? paymentIntentData;


  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Scaffold(
      body: Center (
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120,horizontal: 16),
          child: Column(
            children: [
              CustomButton (title: 'Confirm Payment : \$${widget.totalbill}', onTap: (){
                 makePayment();
                 Timer(Duration(seconds: 6),(){
                   Get.off(HomeScreen());
                   cartController.removecart();
                 });
              }),
            ],
          ),
        )
        ,),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
      await createPaymentIntent(widget.totalbill.toString(), 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            //setupIntentClientSecret: StripeSecretKey,
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              //applePay: true,
              //googlePay: true,
              //testEnv: true,
              customFlow: true,
              style: ThemeMode.dark,
              // merchantCountryCode: 'US',
              merchantDisplayName: 'John'))
          .then((value) {});

      ///now finally display payment sheeet
      await displayPaymentSheet();


    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      await Stripe.instance.confirmPaymentSheetPayment();

      setState(() {
        paymentIntentData = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Paid Successfully")));
    }on StripeException catch (e) {
      print(e.toString());

      showDialog(context: context, builder: (_)=>AlertDialog(
        content: Text("Cancelled"),
      ));
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    double parsedAmount = double.parse(amount);
    int amountInCents = (parsedAmount * 100).toInt();
    return amountInCents.toString();
    }

}
