import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'register.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'MyWallet.dart';
import 'main.dart';
import 'FullMenu.dart';
import 'SmartMess.dart';

import 'Menu.dart';

var lim = 1;
var docu;
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

class FullMenu extends StatefulWidget {
  const FullMenu({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<FullMenu> createState() => _FullMenuState();
}

class _FullMenuState extends State<FullMenu> {
  @override
  Widget build(BuildContext context) {
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
            title: Text("Smart Mess"),
          ),
          body: SfPdfViewer.network(
              'https://drive.google.com/uc?id=1Zti75QVuMYDIOgOG-zv9VVfzXDOwgzcy&export=download'),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
