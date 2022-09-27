import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'MyWallet.dart';
import 'SmartMess.dart';
import 'package:pay/pay.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
String val = "0";

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  @override
  Widget build(BuildContext context) {
    final ureg = widget.title;
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(title: ureg.toUpperCase())),
                  );
                }),
            title: Text("Add Money"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Amount to be added",
                          hintText: "Eg 1000",
                        ),
                        onChanged: (String n) {
                          val = n;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: GooglePayButton(
                      paymentConfigurationAsset:
                          'default_payment_profile_google_pay.json',
                      paymentItems: [PaymentItem(amount: val)],
                      style: GooglePayButtonStyle.black,
                      type: GooglePayButtonType.pay,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: onGooglePayResult,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }
}
