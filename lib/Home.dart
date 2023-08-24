import 'package:avocat/Themes/colors.dart';
import 'package:avocat/main.dart';
import 'package:avocat/screens/home/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    // print(user);
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

  static const IconData subscriptions =
      IconData(0xe618, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
              decoration: BoxDecoration(),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // width: 200,
                    // height: 200,
                    decoration: BoxDecoration(
                        border: Border(),
                        // color: goldenColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        )),
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(),
                            color: goldenColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                        child: SizedBox(
                            height: 180,
                            width: 180,
                            child: const Image(
                                image:
                                    AssetImage('assets/images/ic_launcher.jpg'),
                                     
                                    )
                            //  Image.asset(
                            //   "assets/images/ic_launcher.jpg",
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "هذا التطبيق عبارة عن وسيط إلكتروني بين المحامي والاشخاص الباحثين عن محامي ، سنقدم لك سيدي الباحث عن محامي خدمة إلكترونية من خلال التوسط بينك وبين محامي يتكفل بقضيتك بطريقة سهلة وسريعة تقضي على عبئ المسافة وطول الوقت .",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                MainFunctions.textDirection = TextDirection.rtl;
                                Get.forceAppUpdate();
                                Get.offAllNamed("/home");
                              },
                              child: 
                              Text(
                                " واصل ",
                                style:
                                    TextStyle(color: whiteColor, fontSize: 18),
                              )
                              ,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(greenColor)),
                            ),
                      
                      
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
