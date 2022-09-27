import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'MyProfile.dart';
import 'HomeScreen.dart';
import 'MyWallet.dart';
import 'SmartMess.dart';
import 'FullMenu.dart';
import 'RegisterToken.dart';
import 'main.dart';
import 'PendingToken.dart';
import 'Menu.dart';

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

class SmartMess extends StatefulWidget {
  const SmartMess({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<SmartMess> createState() => _SmartMessState();
}

class _SmartMessState extends State<SmartMess> {
  @override
  Widget build(BuildContext context) {
    var ureg = widget.title;
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  String navi = uureg.toString();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(title: navi.toUpperCase())),
                  );
                }),
            title: Text("Smart Mess"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => Menu(title: "Menu")),
                        );
                      },
                      child: new Container(
                        width: MediaQuery.of(context).size.width - 30,
                        padding: new EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 185, 190, 185),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Today's Menu"),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  FullMenu(title: "Mess Menu")),
                        );
                      },
                      child: new Container(
                        width: MediaQuery.of(context).size.width - 30,
                        padding: new EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 185, 190, 185),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Full Menu"),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterToken(title: "Book Token")),
                        );
                      },
                      child: new Container(
                        width: MediaQuery.of(context).size.width - 30,
                        padding: new EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 185, 190, 185),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Register Your Special Token"),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  PendingToken(title: "Mess Menu")),
                        );
                      },
                      child: new Container(
                        width: MediaQuery.of(context).size.width - 30,
                        padding: new EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 185, 190, 185),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("View My Pending Tokens"),
                      )),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
