import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartmess/firebase_options.dart';
import 'package:smartmess/main.dart';
import 'register.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'MyWallet.dart';
import 'SmartMess.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

var upass,
    ureg,
    reg = "",
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
var dep = [
  "AI&DS",
  "AI&ML",
  "CIVIL",
  "CSBS",
  "CSE",
  "ECE",
  "EEE",
  "E&I",
  "IT",
  "MBA",
  "MECHANICAL"
];
var gen = ["Male", "Female"];
var host = [
  "Old Boys Hostel(Vedha)",
  "New Boys Hostel(Octa)",
  "Dr.Muthulakshmi Reddy Hostel"
];
var cate = ["Veg", "Non-Veg"];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Mess',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.white,
          platform: TargetPlatform.android),
      home: const MyHomePage(title: 'Smart Mess'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var ctime;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Registration / Update Request Form",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      hintText: "Your Name",
                    ),
                    onChanged: (String n) {
                      name = n;
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Register Number",
                      hintText: "Your register Number",
                    ),
                    onChanged: (String n) {
                      reg = n;
                      email = reg.toLowerCase() + "@mkce.ac.in";
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Enter Strong Password",
                    ),
                    onChanged: (String n) {
                      pass = n;
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password",
                      hintText: "Retype your Password",
                    ),
                    onChanged: (String n) {
                      confp = n;
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      "Department :    ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    DropdownButton(
                        value: dept,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: dep.map((String values) {
                          return DropdownMenuItem(
                            value: values,
                            child: Text(values),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() {
                            dept = val!;
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      "Gender :    ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    DropdownButton(
                        value: gender,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: gen.map((String values) {
                          return DropdownMenuItem(
                            value: values,
                            child: Text(values),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() {
                            gender = val!;
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Batch",
                      hintText: "Eg. 2024",
                    ),
                    onChanged: (String n) {
                      batch = n;
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Phone Number",
                      hintText: "Your Phone Number",
                    ),
                    onChanged: (String n) {
                      phone = n;
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      "Hostel :    ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    DropdownButton(
                        value: hostel,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: host.map((String values) {
                          return DropdownMenuItem(
                            value: values,
                            child: Text(values),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() {
                            hostel = val!;
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Room Number",
                      hintText: "Eg. E-201",
                    ),
                    onChanged: (String n) {
                      room = n;
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      "Catregory : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    DropdownButton(
                        value: cat,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cate.map((String values) {
                          return DropdownMenuItem(
                            value: values,
                            child: Text(values),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() {
                            cat = val!;
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: RaisedButton(
                  child: Text("Send Request",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold)),
                  textColor: Colors.white,
                  color: Colors.blue,
                  splashColor: Colors.grey,
                  padding: EdgeInsets.all(25.0),
                  onPressed: () async {
                    var user, userdoc;
                    try {
                      final dbu = await db
                          .collection("users")
                          .doc(reg.toUpperCase())
                          .get();
                      user = dbu["name"];
                      userdoc = dbu;
                    } catch (e) {
                      user = "--";
                    }
                    if (user == "--") {
                      var treg = reg.split(" ");
                      final data = <String, String>{
                        "batch": batch,
                        "cat": cat,
                        "dept": dept,
                        "email": email,
                        "gender": gender,
                        "pass": pass,
                        "hostel": hostel,
                        "name": name.toUpperCase(),
                        "phone": phone,
                        "reg": treg[0].toUpperCase(),
                        "room": room.toUpperCase(),
                      };
                      final dba =
                          db.collection("pending").doc(reg.toUpperCase());
                      bool valid = (pass == confp);
                      if (valid) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email);
                        if (emailValid) {
                          bool validpass = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(pass);
                          if (validpass) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Notice"),
                                content: Text(
                                    "Your Verification is Pending for approval by Admin.To edit changes reapply with Same Register Number\n\nYour email id for login is " +
                                        email),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.blue,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            dba.set(data, SetOptions(merge: true));
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Notice"),
                                content: const Text("Use Strong Password"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.blue,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Notice"),
                              content: const Text(
                                  "Not a Valid Email Address \ncheck if there is space after register number"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    color: Colors.blue,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("okay",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Notice"),
                            content: const Text("Password Mismatch found"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  color: Colors.blue,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("okay",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      var cp = userdoc["pass"];
                      if (confp == pass) {
                        if (confp == cp) {
                          final data = <String, String>{
                            "batch": batch,
                            "cat": cat,
                            "dept": dept,
                            "email": email,
                            "gender": gender,
                            "hostel": hostel,
                            "name": name.toUpperCase(),
                            "phone": phone,
                            "room": room.toUpperCase(),
                            "pass": cp,
                            "reg": reg.toUpperCase(),
                          };
                          final dba =
                              db.collection("pending").doc(reg.toUpperCase());
                          await dba.set(data, SetOptions(merge: true));
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Notice"),
                              content:
                                  const Text("Details Updation request sent"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    color: Colors.blue,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("okay",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Notice"),
                              content: const Text(
                                  "Wrong password for user to update"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    color: Colors.blue,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("okay",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Notice"),
                            content: const Text("Password Mismatch found"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  color: Colors.blue,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("okay",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
