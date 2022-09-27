import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'register.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'MyWallet.dart';
import 'SmartMess.dart';
import 'main.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ureg = widget.title;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Hi , " + widget.title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.logout_outlined),
                onPressed: () async {
                  final _secureStorage = const FlutterSecureStorage();
                  _secureStorage.deleteAll();
                  _secureStorage.write(key: 'set', value: '0');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => LoginPage(title: "Smart Mess")),
                  );
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(height: 40),
              Text("Menu Items",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              Row(children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => SmartMess(title: "Smart Mess")),
                    );
                  },
                  child: new Container(
                    height: 200,
                    width: (MediaQuery.of(context).size.width - 10) / 2,
                    child: Card(
                      color: Color.fromARGB(255, 252, 97, 86),
                      child: Center(
                        child: Column(children: [
                          SizedBox(height: 20),
                          IconButton(
                            icon: const Icon(Icons.food_bank_outlined),
                            iconSize: 60,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SmartMess(title: "Smart Mess")),
                              );
                            },
                          ),
                          Text(
                            "Smart Mess",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                      elevation: 8,
                      shadowColor: Colors.green,
                      margin: EdgeInsets.all(20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              MyProfile(title: ureg.toUpperCase())),
                    );
                  },
                  child: new Container(
                    height: 200,
                    width: (MediaQuery.of(context).size.width - 10) / 2,
                    child: Card(
                      color: Colors.blue,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            IconButton(
                              icon: const Icon(Icons.person),
                              iconSize: 55,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyProfile(title: ureg.toUpperCase())),
                                );
                              },
                            ),
                            Text("My Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      elevation: 8,
                      shadowColor: Colors.green,
                      margin: EdgeInsets.all(20),
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                MyWallet(title: ureg.toUpperCase())),
                      );
                    },
                    child: new Container(
                      height: 200,
                      width: (MediaQuery.of(context).size.width - 10) / 2,
                      child: Card(
                        color: Color.fromARGB(255, 255, 203, 30),
                        child: Center(
                          child: Column(children: [
                            SizedBox(height: 20),
                            IconButton(
                              icon: const Icon(
                                  Icons.account_balance_wallet_outlined),
                              iconSize: 60,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyWallet(title: ureg.toUpperCase())),
                                );
                              },
                            ),
                            Text("My Wallet",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ]),
                        ),
                        elevation: 8,
                        shadowColor: Colors.green,
                        margin: EdgeInsets.all(20),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
