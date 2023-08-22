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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
              decoration: BoxDecoration(
                  // color: Colors.black
                  ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Container(
              //       width: 160,
              //       height: 200,
              //       decoration: BoxDecoration(
              //           border: Border(),
              //           color: goldenColor,
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(15),
              //           )),
              //       child: Column(children: [
              //         SizedBox(
              //           height: 90,
              //           width: 90,
              //           child: Image.asset(
              //             "assets/images/lawyer.png",
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //         Container(
              //           decoration: BoxDecoration(color: goldenColor),
              //           child: Column(
              //             children: [
              //               TextButton(
              //                 onPressed: () {
              //                   MainFunctions.textDirection = TextDirection.rtl;
              //                   Get.forceAppUpdate();
              //                   Get.toNamed("/avocatLogin");
              //                 },
              //                 child: Text(
              //                   "   هل أنت محامي ؟",
              //                   style:
              //                       TextStyle(color: whiteColor, fontSize: 18),
              //                 ),
              //                 style: ButtonStyle(
              //                     backgroundColor:
              //                         MaterialStateProperty.all(goldenColor)),
              //               ),
              //               TextButton(
              //                 onPressed: () {
              //                   MainFunctions.textDirection = TextDirection.rtl;
              //                   Get.forceAppUpdate();
              //                   Get.toNamed("/avocatLogin");
              //                 },
              //                 child: Text(
              //                   "انضم إلينا",
              //                   style:
              //                       TextStyle(color: whiteColor, fontSize: 18),
              //                 ),
              //                 style: ButtonStyle(
              //                     backgroundColor:
              //                         MaterialStateProperty.all(greenColor)),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ]),
              //     )
              //   ],
              // ),
            ),
            const SizedBox(
              width: 20,
            ),
            // IconButton(onPressed: (){}, icon: Icon()),
            // TextButton.icon(
            //     style: ButtonStyle(
            //         backgroundColor:
            //             MaterialStateProperty.all(goldenColor),
            //         iconColor: MaterialStateProperty.all(whiteColor),
            //         foregroundColor:
            //             MaterialStateProperty.all(goldenColor)),
            //     onPressed: () {},
            //     icon: const Text(                "هل تبحث عن محامي ",

            //         style: TextStyle(fontWeight: FontWeight.bold , color: whiteColor)),

            //     label: const Icon(Icons.arrow_back_ios_new )

            //     ),

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
                          child: Image.asset(
                            "assets/images/ic_launcher.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(color: goldenColor),
                        child: Column(
                          children: [
                            //       TextButton(
                            //         onPressed: () {
                            //           MainFunctions.textDirection = TextDirection.rtl;
                            //           Get.forceAppUpdate();
                            //  Get.toNamed("/clientLogin");
                            //         },
                            //         child: Text(
                            //                "هل تبحث عن محامي ؟",
                            //           style:
                            //               TextStyle(color: whiteColor, fontSize: 18),
                            //         ),
                            //         style: ButtonStyle(
                            //             backgroundColor:
                            //                 MaterialStateProperty.all(goldenColor)),
                            //       ),

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
                              child: Text(
                                " واصل ",
                                style:
                                    TextStyle(color: whiteColor, fontSize: 18),
                              ),
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

            // TextButton(
            //   onPressed: () {
            //     MainFunctions.textDirection = TextDirection.rtl;
            //     Get.forceAppUpdate();
            //     Get.toNamed("/clientLogin");
            //   },
            //   child: Text(
            //     "هل تبحث عن محامي ",
            //     style: TextStyle(color: whiteColor, fontSize: 18),
            //   ),
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(goldenColor),
            //     // animationDuration: Duration(microseconds: 15),
            //   ),
            // ),
          ])),
    );
  }
}
