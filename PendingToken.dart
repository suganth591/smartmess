import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'PendingToken.dart';
import 'SmartMess.dart';
import 'Menu.dart';
import 'package:intl/intl.dart';

var lim = 1, fd1, fd2, isloading = true;
FirebaseFirestore db = FirebaseFirestore.instance;

class PendingToken extends StatefulWidget {
  const PendingToken({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<PendingToken> createState() => _PendingTokenState();
}

class _PendingTokenState extends State<PendingToken> {
  @override
  Widget build(BuildContext context) {
    final dba1 = db.collection(DateFormat("yyyy-MM-dd").format(DateTime.now()));
    final dba2 = db.collection(
        DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1))));
    getdata() async {
      final data1 = await dba1.doc(uureg).get();
      final data2 = await dba2.doc(uureg).get();
      var tfd1 = await data1.data();
      var tfd2 = await data2.data();
      setState(() {
        fd1 = tfd1;
        fd2 = tfd2;
        isloading = false;
      });
    }

    if (lim > 0) {
      lim -= 1;
      getdata();
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
              title: Text("My Pending Tokens"),
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
                            height: 40,
                          ),
                          (fd1 == null && fd2 == null)
                              ? Text("No Pending Token")
                              : Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  child: Center(
                                    child: Column(
                                      children: [
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
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text("Date",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                                Center(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text("veg",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                                Center(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text("Non-Veg",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                                Center(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text("Timing",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              ],
                                            ),
                                            (fd1 != null &&
                                                    fd1["validity"] == "1")
                                                ? (TableRow(
                                                    children: [
                                                      Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .format(DateTime
                                                                    .now()))),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(fd1[
                                                                "vegcount"])),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(fd1[
                                                                "nonvegcount"])),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(
                                                                fd1["time"])),
                                                      ),
                                                    ],
                                                  ))
                                                : TableRow(
                                                    children: [
                                                      SizedBox(height: 0),
                                                      SizedBox(height: 0),
                                                      SizedBox(height: 0),
                                                      SizedBox(height: 0),
                                                    ],
                                                  ),
                                            (fd2 != null &&
                                                    fd2["validity"] == "1")
                                                ? (TableRow(
                                                    children: [
                                                      Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .format(DateTime
                                                                        .now()
                                                                    .add(Duration(
                                                                        days:
                                                                            1))))),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(fd2[
                                                                "vegcount"])),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(fd2[
                                                                "nonvegcount"])),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(
                                                                fd2["time"])),
                                                      ),
                                                    ],
                                                  ))
                                                : TableRow(
                                                    children: [
                                                      SizedBox(height: 0),
                                                      SizedBox(height: 0),
                                                      SizedBox(height: 0),
                                                      SizedBox(height: 0),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )),
        onWillPop: () async {
          return false;
        });
  }
}
