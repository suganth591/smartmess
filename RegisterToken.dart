import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_kronos/flutter_kronos.dart';
import 'SmartMess.dart';

var cd = DateTime.now(), ctc = 1;
var maxt, mint;
var isloading = true;
var date = "", processing = 0;
int isopen = 0, ec = 0;
var td1 = "";
var regi = uureg;
var lim = 1;
int nvc = 0, vc = 0;
int totalprice = 0;
var price, special;
FirebaseFirestore db = FirebaseFirestore.instance;
var ts;
final dba1 = db.collection("specialprice");
final dbs1 = db.collection("special");

class RegisterToken extends StatefulWidget {
  const RegisterToken({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<RegisterToken> createState() => _RegisterTokenState();
}

class _RegisterTokenState extends State<RegisterToken> {
  @override
  Widget build(BuildContext context) {
    var nextdate = DateFormat('EEEE')
        .format(DateTime.now().add(Duration(days: 1)))
        .toString();
    td1 = nextdate[0] + nextdate[1] + nextdate[2];
    td1 = td1.toLowerCase();
    timeget() async {
      var temp = await FlutterKronos.getNtpDateTime;
      var gett = await dbs1.doc(td1).get();
      setState(() {
        maxt = int.parse(gett['max']);
        mint = int.parse(gett['min']);
      });
      var tempntp = DateFormat("dd/MM/yyyy hh:mm:ss")
          .format(DateTime.parse(temp.toString()))
          .toString();
      var tempdt =
          DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.now()).toString();
      setState(() {
        if (tempntp == tempdt) {
          ctc = 1;
          ec = 0;
        } else {
          ec += 1;
          if (ec > 50) {
            ctc = 0;
          }
        }
      });
    }

    if (lim > 0) {
      timeget();
      lim -= 1;
    }
    lim = 1;
    var time = DateFormat("HH").format(DateTime.now()).toString();
    int curr = int.parse(time);
    if (curr >= mint && curr < maxt) {
      isopen = 1;
    }

    getittomo() async {
      var doct = await dba1.doc(td1).get();
      var spet = await dbs1.doc(td1).get();
      setState(() {
        price = doct.data();
        special = spet.data();
        isloading = false;
      });
    }

    if (lim > 0) {
      lim -= 1;
      getittomo();
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
            title: Text("Book Special Token"),
          ),
          body: (isloading)
              ? Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      child: CircularProgressIndicator()),
                )
              : (price['vegprice'] == '0' || isopen == 0)
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: Text(
                                "No Special Token Booking is Available Open Now \n\nTry to Book tokens on the before day between (06:00 AM - 02:00 PM)",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ),
                      ],
                    )
                  : (ctc == 0)
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "Adjust Correct Time in Your Device To Access this Page",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "Book Special Token for " +
                                      DateFormat('dd/MM/yyyy')
                                          .format(cd.add(Duration(days: 1)))
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 40),
                                Table(
                                  border: TableBorder.all(
                                      color: Colors.grey,
                                      width: 2,
                                      style: BorderStyle.solid),
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(1.5),
                                    3: FlexColumnWidth(1),
                                    4: FlexColumnWidth(0.01)
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                "Veg / Non - Veg",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                "Food Name",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                "Food Price",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                "Timing",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text("Veg")),
                                        ),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(special["veg"])),
                                        ),
                                        Center(
                                            child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                    "₹ " + price["vegprice"]))),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(special["type"])),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text("Non-Veg")),
                                        ),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(special["nonveg"])),
                                        ),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                  "₹ " + price["nonvegprice"])),
                                        ),
                                        Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(special["type"])),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    child: Text(
                                      "Book My Tokens",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Non-Veg Token : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      SizedBox(
                                          height: 30,
                                          width: 60,
                                          child: FlatButton(
                                            color: Color.fromARGB(
                                                255, 219, 218, 218),
                                            onPressed: () {
                                              if (nvc - 1 >= 0) {
                                                nvc -= 1;
                                                totalprice -= int.parse(
                                                    price["nonvegprice"]);
                                                setState(() {});
                                              }
                                            },
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                fontSize: 30,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                      Text("     " + nvc.toString() + "     ",
                                          style: TextStyle(fontSize: 18)),
                                      SizedBox(
                                          height: 30,
                                          width: 60,
                                          child: FlatButton(
                                            color: Color.fromARGB(
                                                255, 219, 218, 218),
                                            onPressed: () {
                                              nvc += 1;
                                              totalprice += int.parse(
                                                  price["nonvegprice"]);
                                            },
                                            child: Text("+",
                                                style: TextStyle(fontSize: 18)),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Veg Token :          ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      SizedBox(
                                          height: 30,
                                          width: 60,
                                          child: FlatButton(
                                            color: Color.fromARGB(
                                                255, 219, 218, 218),
                                            onPressed: () {
                                              if (vc - 1 >= 0) {
                                                vc -= 1;
                                                totalprice -= int.parse(
                                                    price["vegprice"]);
                                                setState(() {});
                                              }
                                            },
                                            child: Text("-",
                                                style: TextStyle(fontSize: 30)),
                                          )),
                                      Text("     " + vc.toString() + "     ",
                                          style: TextStyle(fontSize: 18)),
                                      SizedBox(
                                          height: 30,
                                          width: 60,
                                          child: FlatButton(
                                            color: Color.fromARGB(
                                                255, 219, 218, 218),
                                            onPressed: () {
                                              totalprice +=
                                                  int.parse(price["vegprice"]);
                                              vc += 1;
                                            },
                                            child: Text("+",
                                                style: TextStyle(fontSize: 18)),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  color: Color.fromARGB(255, 255, 230, 0),
                                  child: Text(
                                    "Total price = ₹ " + totalprice.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 50),
                                FlatButton(
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (vc != 0 || nvc != 0) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                title:
                                                    Text("Token Confirmation "),
                                                content: Text("VEG TOKEN : " +
                                                    vc.toString() +
                                                    "\nNON-VEG TOKEN : " +
                                                    nvc.toString() +
                                                    "\n\nTOTAL PRICE : ₹" +
                                                    totalprice.toString()),
                                                actions: <Widget>[
                                                  TextButton(
                                                      onPressed: () async {
                                                        if (processing == 0) {
                                                          setState(() {
                                                            processing = 1;
                                                          });
                                                          uureg = uureg
                                                              .toUpperCase();
                                                          setState(() {
                                                            if (special ==
                                                                null) {
                                                              isloading = true;
                                                            } else {
                                                              isloading = false;
                                                            }
                                                          });
                                                          int isins = 0;
                                                          final wall = await db
                                                              .collection(
                                                                  "wallet")
                                                              .doc(uureg)
                                                              .get();
                                                          var twall =
                                                              wall.data();
                                                          print(twall);
                                                          print(
                                                              "uu = " + uureg);
                                                          if (int.parse(twall![
                                                                  "total"]) >=
                                                              totalprice) {
                                                            final dbu = db
                                                                .collection(DateFormat(
                                                                        "yyyy-MM-dd")
                                                                    .format(DateTime
                                                                            .now()
                                                                        .add(Duration(
                                                                            days:
                                                                                1)))
                                                                    .toString())
                                                                .doc(uureg);
                                                            try {
                                                              final td = await db
                                                                  .collection(
                                                                      "token")
                                                                  .doc(DateFormat(
                                                                          "yyyy-MM-dd")
                                                                      .format(DateTime
                                                                              .now()
                                                                          .add(Duration(
                                                                              days: 1)))
                                                                      .toString());
                                                              var td1 = await td
                                                                  .get();
                                                              var data =
                                                                  td1.data();
                                                              data!["vc"] =
                                                                  (int.parse(data[
                                                                              "vc"]) +
                                                                          vc)
                                                                      .toString();
                                                              data["nvc"] =
                                                                  (int.parse(data[
                                                                              "nvc"]) +
                                                                          nvc)
                                                                      .toString();
                                                              await td.set(
                                                                  data,
                                                                  SetOptions(
                                                                      merge:
                                                                          true));
                                                            } catch (e) {
                                                              final data = {
                                                                "date": DateFormat(
                                                                        "yyyy-MM-dd")
                                                                    .format(DateTime
                                                                            .now()
                                                                        .add(Duration(
                                                                            days:
                                                                                1)))
                                                                    .toString(),
                                                                "vc": vc
                                                                    .toString(),
                                                                "nvc": nvc
                                                                    .toString(),
                                                              };
                                                              await db
                                                                  .collection(
                                                                      "token")
                                                                  .doc(DateFormat(
                                                                          "yyyy-MM-dd")
                                                                      .format(DateTime
                                                                              .now()
                                                                          .add(Duration(
                                                                              days: 1)))
                                                                      .toString())
                                                                  .set(data);
                                                            }
                                                            final check1 =
                                                                await dbu.get();
                                                            final check =
                                                                check1.data();
                                                            var data = {
                                                              "vegcount":
                                                                  vc.toString(),
                                                              "nonvegcount": nvc
                                                                  .toString(),
                                                              "price": totalprice
                                                                  .toString(),
                                                              "ts": DateTime
                                                                      .now()
                                                                  .toString(),
                                                              "reg": uureg,
                                                              "time": special[
                                                                  'type'],
                                                              "validity": "1"
                                                            };
                                                            var data1 = {
                                                              "vegcount":
                                                                  vc.toString(),
                                                              "nonvegcount": nvc
                                                                  .toString(),
                                                              "price": totalprice
                                                                  .toString(),
                                                              "ts": DateTime
                                                                      .now()
                                                                  .toString(),
                                                              "reg": uureg,
                                                              "time": special[
                                                                  'type'],
                                                            };
                                                            try {
                                                              var ee =
                                                                  check1["reg"];
                                                              String tempvc =
                                                                  (int.parse(check1[
                                                                              "vegcount"]) +
                                                                          vc)
                                                                      .toString();
                                                              String tempnvc =
                                                                  (int.parse(check1[
                                                                              "nonvegcount"]) +
                                                                          nvc)
                                                                      .toString();
                                                              String temptp = (int
                                                                          .parse(
                                                                              check1["price"]) +
                                                                      totalprice)
                                                                  .toString();
                                                              final data = {
                                                                "vegcount":
                                                                    tempvc,
                                                                "nonvegcount":
                                                                    tempnvc,
                                                                "price": temptp,
                                                                "ts": DateTime
                                                                        .now()
                                                                    .toString(),
                                                                "reg": uureg,
                                                                "time": special[
                                                                    "type"],
                                                                "validity": "1"
                                                              };
                                                              await dbu
                                                                  .set(data);
                                                            } catch (e) {
                                                              print("catch block " +
                                                                  e.toString());
                                                              await dbu
                                                                  .set(data);
                                                            }
                                                            final wall2 =
                                                                await db
                                                                    .collection(
                                                                        "wallet")
                                                                    .doc(uureg);
                                                            var datedata =
                                                                await FlutterKronos
                                                                    .getNtpDateTime;
                                                            final data3 = {
                                                              "amount": totalprice
                                                                  .toString(),
                                                              "type": "debited",
                                                              "ts": DateTime
                                                                      .now()
                                                                  .toString(),
                                                              "reg": uureg,
                                                              "source":
                                                                  "Paid for Token"
                                                            };
                                                            await db
                                                                .collection(
                                                                    "trans")
                                                                .doc(DateTime
                                                                        .now()
                                                                    .toString())
                                                                .set(data3);
                                                            twall["total"] =
                                                                (int.parse(twall[
                                                                            "total"]) -
                                                                        totalprice)
                                                                    .toString();
                                                            await wall2
                                                                .set(twall);
                                                            setState(() {
                                                              processing = 0;
                                                            });
                                                            showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AlertDialog(
                                                                title: const Text(
                                                                    "Notice"),
                                                                content: Text(
                                                                    "Token Booked"),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              ctx)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .blue,
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              14),
                                                                      child: const Text(
                                                                          "okay",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          } else {
                                                            isins = 1;
                                                            showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AlertDialog(
                                                                title: Text(
                                                                    "Insufficient Balance"),
                                                                content: Text(
                                                                    "Try after Recharging your Wallet"),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          processing =
                                                                              0;
                                                                        });
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          "okay"))
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                          if (isins == 0) {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      SmartMess(
                                                                          title:
                                                                              "Smart Mess")),
                                                            );
                                                          }
                                                          setState(() {
                                                            isloading = false;
                                                          });
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder: (ctx) =>
                                                                AlertDialog(
                                                              title: Text(
                                                                  "Wait a while"),
                                                              content: Text(
                                                                  "Existing process in your account --- TOO MANY ATTEMPTS THAN EXPECTED"),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                        "okay"))
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Text("Confirm")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Cancel")),
                                                ],
                                              ));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text("Count is 0"),
                                          content: Text(
                                              "Token count cannot be Zero"),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("okay"))
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: Text("Proceed to Buy",
                                      style: TextStyle(fontSize: 20)),
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
}
