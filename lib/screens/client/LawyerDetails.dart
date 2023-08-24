import 'package:avocat/Themes/colors.dart';
import 'package:avocat/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart ' as UrlLauncher;

class LawyerDetails extends StatefulWidget {
  const LawyerDetails({super.key});

  @override
  State<LawyerDetails> createState() => _LawyerDetailsState();
}

class _LawyerDetailsState extends State<LawyerDetails> {
  bool isLogin = false;
  var data;
  var lawyerid;
  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');

//       Navigator.pushReplacement(
// context,MaterialPageRoute(builder: (context) => SingIn()),);
// Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        print('User is signed in!');
        setState(() {
          data = user;
          lawyerid = Get.arguments["userID"];
        });
      }
    });
  }

  var db = FirebaseFirestore.instance;
  var userNAme;
  Future sendRequest() async {
    Get.defaultDialog(
        onWillPop: () {
          return Future.value();
        },
        barrierDismissible: false,
        title: "يرجى الانتظار",
        content: const CircularProgressIndicator(
          backgroundColor: goldenColor,
        ));
    try {
      // print();
      print("/////////bef");
      print(lawyerid);
      var doc = db.collection("issues").doc();
      var docClient = db.collection("users").doc(data!.uid);
      docClient.get().then((snapshot) {
        setState(() {
          userNAme = snapshot.data()!;
        });
      },);
      print("/////////bef2");
      print(userNAme);
      docClient.update({
        "issuesID": FieldValue.arrayUnion([doc.id]),
      });
      print("/////////bef3");
      doc.set({
        // "userName" :userNAme,
        "userID": docClient.id,
        "lawyerID": lawyerid,
      });
      // FirebaseFirestore.instance.collection("issues").doc().set({
      //   "lawyerID": Get.arguments["userID"],
      //   // FieldValue.arrayUnion([travails.id]),
      //   // "userWilaya": _selectedLocation,
      //   // "clientID" : ,
      //   // "userCV" : "",
      // });
      Get.back();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text("تم حفظ طلبك بنجاح إنتظر رد المحامي ")));
      Get.back();
      print('////////////////////////////////////// DONE');
    } catch (e) {
      print(e);
    }
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await UrlLauncher.canLaunchUrl(_phoneUri))
        await UrlLauncher.launchUrl(_phoneUri);
    } catch (error) {
      throw ("//////////////Cannot dial");
    }
  }

  Future tee() async {
    print(Get.arguments['userID']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات المحامي "),
        backgroundColor: goldenColor,
         leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon:
            Icon(Icons.arrow_back_ios_rounded)
            ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // UrlLauncher.launch('mailto:${p.email}'),
            Text(" إسم المحامي : ${Get.arguments["userName"]} ",
                style: TextStyle(fontSize: 18)),

                    Text(" ولاية : ${Get.arguments["userWilaya"]} ",
                style: TextStyle(fontSize: 18)),
            TextButton(
              onPressed: () {
                UrlLauncher.launch('mailto:${Get.arguments["userEmail"]}');
              },
              child: Text(
                "  البريد الإلكتروني  :${Get.arguments["userEmail"]}",
                style: TextStyle(fontSize: 18, color: greenColor),
              ),
            ),

            // Text(" رقم هاتف المحامي : ${Get.arguments["userPhoneNumber"]} ",
            //     style: TextStyle(fontSize: 18)),

            TextButton(
              onPressed: () {
                // UrlLauncher.launch('tel:+${Get.arguments["userPhoneNumber"]}');
                // UrlLauncher.launch("tel://");

                launchPhoneDialer(Get.arguments["userPhoneNumber"]);

                // UrlLauncher.launch('mailto:${p.email}'),
              },
              child: Text(
                  " رقم هاتف المحامي : ${Get.arguments["userPhoneNumber"]} ",
                  style: TextStyle(fontSize: 18, color: greenColor)),
            ),
           
           
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  //  tee();
                  sendRequest();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(greenColor)),
                child: Text(
                  "  إرسال طلب بلاغ للمحامي",
                  style: TextStyle(color: whiteColor, fontSize: 18),
                )),
            // const SizedBox(
            //   height: 10,
            // ),
            // TextButton(
            //     onPressed: () {
            //       Get.defaultDialog(
            //           onWillPop: () {
            //             return Future.value();
            //           },
            //           barrierDismissible: false,
            //           title: "يرجى الانتظار",
            //           content: const CircularProgressIndicator(
            //             backgroundColor: goldenColor,
            //           ));
            //       FirebaseFirestore.instance
            //           .collection("users")
            //           .doc(Get.arguments["userID"])
            //           .update({
            //         "isAccepted?": true,
            //       });
            //       Get.back();
            //       Get.back();
            //     },
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all(greenColor)),
            //     child: Text(
            //       "الموافقة على ضم المحامي",
            //       style: TextStyle(color: whiteColor, fontSize: 18),
            //     ))
          ],
        ),
      ),
    );
  }
}
