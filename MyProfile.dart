import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartmess/main.dart';
import 'register.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'MyWallet.dart';
import 'SmartMess.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
var name = "Loading",
    reg = "loading",
    dept = "Loading",
    batch = "loading",
    room = "Loading",
    hostel = "loading",
    phone = "loading",
    pass = "loading",
    email = "loading",
    gender = "loading",
    cat = "loading";
int lim = 1;
var avl =
    "data:image/png;base64,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";

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final ureg = widget.title;
    final db = FirebaseFirestore.instance.collection("users").doc(ureg).get();
    getDetails() async {
      final temp = await db;
      setState(() {
        name = temp["name"];
        reg = temp["reg"];
        dept = temp["dept"];
        cat = temp["cat"];
        batch = temp["batch"];
        room = temp["room"];
        hostel = temp["hostel"];
        phone = temp["phone"];
        email = temp["email"];
        pass = temp["pass"];
        gender = temp["gender"];
        if (gender == "Male") {
          avl =
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYIMmE0bLUSDD7LII20c-b06qmFH_ZWUqUQA&usqp=CAU";
        } else {
          avl =
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-D1aqITlTbUFjzmHPt7b_UedzcoasaI5rbA&usqp=CAU";
        }
      });
    }

    while (lim != 0) {
      lim -= 1;
      getDetails();
    }
    lim = 1;
    TableRow field(String fn, String fv) {
      return (TableRow(
        children: [
          Text(fn, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(fv, style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
        ],
      ));
    }

    ;
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
              title: Text("My Profile"),
            ),
            body: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 100,
                                  backgroundImage: NetworkImage(avl),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Table(
                                columnWidths: {
                                  0: FlexColumnWidth(3),
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(0.3),
                                },
                                children: [
                                  field("Name", name),
                                  field("Department", dept),
                                  field("Register Number", reg),
                                  field("Batch", batch),
                                  field("Email Address", email),
                                  field("Gender", gender),
                                  field("Hostel", hostel),
                                  field("Category", cat),
                                  field("Room Number", room),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        onWillPop: () async {
          return false;
        });
  }
}
