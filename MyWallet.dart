import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'AddMoney.dart';
import 'MyWallet.dart';
import 'MyTransactions.dart';
import 'SmartMess.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
var upass,
    uemail,
    ureg,
    batch,
    name,
    cat = "Non-Veg",
    dept = "CSBS",
    email,
    confp,
    gender = "Male",
    pass,
    hostel = "New Boys Hostel(Octa)",
    phone,
    room;
String total = "";
int lim = 1;

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    final ureg = widget.title;
    final db = FirebaseFirestore.instance.collection("wallet").doc(ureg).get();
    func() async {
      final doc = await db;
      setState(() {
        total = doc['total'];
      });
    }

    ;
    if (lim != 0) {
      lim -= 1;
      func();
    }
    lim = 1;
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
            title: Text("My Wallet"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Color.fromARGB(255, 255, 196, 0),
                    ),
                    width: 380,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Available Balance in Wallet : ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Rs. " + total,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                AddMoney(title: ureg.toUpperCase())),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add Money"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                MyTransactions(title: ureg.toUpperCase())),
                      );
                    },
                    icon: Icon(Icons.lock_clock),
                    label: Text("View My Transactions"),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
