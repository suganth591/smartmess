import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartmess/SmartMess.dart';
import 'register.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'MyWallet.dart';
import 'Menu.dart';
import 'main.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
var date = "", fd;
var today, special;
int lim = 1;
var isloading = true;
final dba = db.collection("mess").doc(date).get();
final dbs = db.collection("special").doc(date).get();

class Menu extends StatefulWidget {
  const Menu({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    String td = DateFormat('EEEE').format(DateTime.now()).toString();
    fd = td;
    date = td[0] + td[1] + td[2];
    date = date.toLowerCase();
    getit() async {
      final doc = await dba;
      final spe = await dbs;
      setState(() {
        today = doc.data();
        special = spe.data();
        isloading = false;
      });
    }

    if (lim > 0) {
      lim -= 1;
      getit();
    }
    Widget getwid() {
      return (Container(
        child: Column(children: [
          Text(
              fd +
                  "  " +
                  DateFormat('(d / MM )').format(DateTime.now()).toString(),
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          SizedBox(
            height: 30,
          ),
          Text(
            "Normal Food",
            style: TextStyle(
                color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 25,
            child: Table(
              border: TableBorder.all(
                  color: Colors.grey, width: 2, style: BorderStyle.solid),
              columnWidths: {
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(0.001),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Morning Drinks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Text(today["tea"]),
                      ),
                    ),
                    SizedBox(height: 50)
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'BreakFast',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Text(today["breakfast"].toString()),
                      ),
                    ),
                    SizedBox(height: 80)
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Lunch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Text(today["lunch"]),
                      ),
                    ),
                    SizedBox(height: 80)
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Snacks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Text(today["snacks"]),
                      ),
                    ),
                    SizedBox(height: 80)
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Dinner',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Text(today["dinner"]),
                      ),
                    ),
                    SizedBox(height: 80)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Special Food",
            style: TextStyle(
                color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 25,
            child: Table(
              border: TableBorder.all(
                  color: Colors.grey, width: 2, style: BorderStyle.solid),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(0.001),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Veg',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(special["veg"]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(special["type"]),
                      ),
                    ),
                    Center(
                      child: SizedBox(height: 40),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Non - Veg',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(special["nonveg"]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(special["type"]),
                      ),
                    ),
                    Center(
                      child: SizedBox(height: 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
        ]),
      ));
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
                        builder: (context) => SmartMess(title: "Smart Mess")),
                  );
                }),
            title: Text("Today's Menu"),
          ),
          body: (isloading)
              ? Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        for (var i = 0; i < 1; i++) getwid(),
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
