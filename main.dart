import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartmess/firebase_options.dart';
import 'register.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'HomeScreen.dart';
import 'MyProfile.dart';
import 'MyWallet.dart';
import 'SmartMess.dart';

bool wait = false;
FirebaseFirestore db = FirebaseFirestore.instance;
var upass,
    isloading = true,
    uemail = "*",
    ureg,
    uureg,
    batch,
    uuemail,
    uupass,
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
      home: const LoginPage(title: 'Smart Mess'),
      //home: const MyProfile(title: '20BCB4041'),
      //home: const HomeScreen(title: '20BCB4041'),
      //home: const MyWallet(title: '20BCB4041'),
      //home: const SmartMess(title: '20BCB4041'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _secureStorage = const FlutterSecureStorage();
    Future<void> writeSecureData(String ureg, String upass) async {
      setState(() {});
      await _secureStorage.deleteAll();
      print("Added " + ureg);
      await _secureStorage.write(
          key: "email", value: ureg.toLowerCase() + "@mkce.ac.in");
      await _secureStorage.write(key: "reg", value: ureg);
      await _secureStorage.write(key: "pass", value: upass);
      await _secureStorage.write(key: "isset", value: "1");
    }

    Future<void> check() async {
      uuemail = await _secureStorage.read(key: "email");
      uupass = await _secureStorage.read(key: "pass");
      var ureg = await _secureStorage.read(key: "reg");
      try {
        String se = uuemail!;
        final UserCredential? user =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: uuemail,
          password: uupass!,
        );
        setState(() {
          uureg = ureg;
          isloading = false;
        });
        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => HomeScreen(title: ureg!.toUpperCase())),
          );
        } else {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Auto Verification Failed"),
              content: Text("Try Login With Your Credentials Again"),
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
      } catch (e) {
        setState(() {
          isloading = false;
        });
      }
    }

    check();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
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
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "Login Form",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Register Number",
                            hintText: "Your College Register Number",
                          ),
                          onChanged: (String n) {
                            ureg = n;
                            uureg = n;
                            uemail = ureg.toLowerCase() + "@mkce.ac.in";
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            hintText: "Your Password Here",
                          ),
                          onChanged: (String n) {
                            upass = n;
                          }),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: RaisedButton(
                            child: Text("Login",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            textColor: Colors.white,
                            color: Colors.blue,
                            splashColor: Colors.grey,
                            padding: EdgeInsets.all(20.0),
                            onPressed: () async {
                              String er = "";
                              try {
                                final UserCredential? user = await FirebaseAuth
                                    .instance
                                    .signInWithEmailAndPassword(
                                  email: uemail,
                                  password: upass,
                                );
                                if (user != null) {
                                  writeSecureData(ureg, upass);
                                  final userup = db
                                      .collection("users")
                                      .doc(uureg.toUpperCase());
                                  Map<String, dynamic> data = {"pass": upass};
                                  await userup.set(
                                      data, SetOptions(merge: true));
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                            title: ureg.toUpperCase())),
                                  );
                                }
                              } on FirebaseAuthException catch (e) {
                                print('Failed with error code: ${e.code}');
                                print(e.message);
                                er = e.code;
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Notice"),
                                    content:
                                        Text("Invalid Credentials\n\n" + er),
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
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: RaisedButton(
                            child: Text("Register / Update",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            textColor: Colors.white,
                            color: Colors.blue,
                            splashColor: Colors.grey,
                            padding: EdgeInsets.all(20.0),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyHomePage(title: "Smart Mess")),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
