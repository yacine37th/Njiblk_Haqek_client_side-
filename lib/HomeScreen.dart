import 'package:avocat/Themes/colors.dart';
import 'package:avocat/main.dart';
import 'package:avocat/screens/home/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var data;
  var de = false;
  bool isLogin = true;
  bool login = false;
  Future islog() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isLogin = false;
        });
        print(isLogin);
//       Navigator.pushReplacement(
// context,MaterialPageRoute(builder: (context) => SingIn()),);
// Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        print('User is signed in!');
        // setState(() {
        //   isLogin = true;
        // });

        print(user.uid);
        print(isLogin);

        FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get()
            .then((snapshot) {
          // Use ds as a snapshot
          setState(() {
            data = snapshot.data()!;
            print('Values from db /////////////////////////////////: ' +
                data["TypeUser"]);
          });

          if (data["TypeUser"] == "etudiant") {
            print('etudiant');
            setState(() {
              de = true;
            });
            Get.back();
          } else {
            print('ensignant');
            setState(() {
              de = false;
            });
            Get.back();
          }

          // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
        });
      }
    });
  }

  @override
  void initState() {
    // print(user);
    islog();
    super.initState();
  }

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Subscription',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    Test(),
    Test(),
    Test(),
    Test(),
  ];
  static const IconData subscriptions =
      IconData(0xe618, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('الصفحة الرئيسية'),
      //   backgroundColor: greenColor,
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   // selectedIconTheme:  IconThemeData(
      //   //   color:  Color.fromRGBO(32, 48, 61, 1),

      //   // ),

      //   // unselectedIconTheme: IconThemeData(
      //   //   color:  Colors.blackS

      //   // ),
      //   // selectedIconTheme: IconThemeData(color: Colors.red),
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "الرئيسية",
      //       // backgroundColor: Colors.blue,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.document_scanner),
      //       label: "الرئيسية",
      //       // backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.table_chart),
      //       label: "الرئيسية",
      //       // backgroundColor: Colors.purple,
      //     ),
      //     BottomNavigationBarItem(
      //       // icon: Icon(Icons.settings),
      //       // label: 'Settings',
      //       icon: Icon(Icons.person_2),
      //       label: "حسابي",
      //       // backgroundColor: Colors.pink,
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),

      // body: screens[_selectedIndex],
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                MainFunctions.textDirection = TextDirection.rtl;
                Get.forceAppUpdate();
                Get.toNamed("/avocatLogin");
              },
              child: Text(
                "هل أنت محاحي ",
                style: TextStyle(color: whiteColor, fontSize: 18),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(goldenColor)),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {
                   MainFunctions.textDirection = TextDirection.rtl;
                Get.forceAppUpdate();
                Get.toNamed("/clientLogin");
              },
              child: Text(
                "هل تبحث عن محامي ",
                style: TextStyle(color: whiteColor, fontSize: 18),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(goldenColor),
                // animationDuration: Duration(microseconds: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
