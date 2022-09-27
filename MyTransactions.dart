import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'MyWallet.dart';
import 'package:intl/intl.dart';
import 'SmartMess.dart';
import 'package:pay/pay.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
String val = "0";
var tablevals;
int lim = 1;

class MyTransactions extends StatefulWidget {
  const MyTransactions({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyTransactions> createState() => _MyTransactionsState();
}

class _MyTransactionsState extends State<MyTransactions> {
  @override
  Widget build(BuildContext context) {
    final ureg = widget.title;
    getTable() async {
      if (tablevals == null) {
        setState(() {
          isloading = true;
        });
      }
      final tempdba = await db
          .collection("trans")
          .orderBy("ts", descending: true)
          .where("reg", isEqualTo: ureg);
      final dba = await tempdba.get();
      final doc = dba.docs.map((doc) => doc.data()).toList();
      setState(() {
        tablevals = doc;
        isloading = false;
      });
    }

    if (lim > 0) {
      lim -= 1;
      getTable();
    }
    lim = 1;
    TableRow tabler(i) {
      return (TableRow(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                DateFormat("dd-MM-yyyy , hh:mm")
                    .format(DateTime.parse(i["ts"]))
                    .toString(),
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                i["type"],
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                i["amount"],
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                i["source"],
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ));
    }

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
            title: Text("My Transactions"),
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
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Text(
                            "Latest 100 Transactions",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Table(
                            border: TableBorder.all(
                                color: Colors.grey,
                                width: 2,
                                style: BorderStyle.solid),
                            children: [
                              TableRow(
                                children: [
                                  Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Type",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "amount",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "source",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                              for (var i in tablevals) tabler(i),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
