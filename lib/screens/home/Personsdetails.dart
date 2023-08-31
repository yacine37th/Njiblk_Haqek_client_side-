import 'package:avocat/Themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart ' as UrlLauncher;

class PersonDetails extends StatefulWidget {
  const PersonDetails({super.key});

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  var currentUser;
  var data;
  bool verif = false;
  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(Get.arguments["userID"])
        .get()
        .then((snapshot) {
      // Use ds as a snapshot
      setState(() {
        data = snapshot.data()!;
        verif = true;
      });
      // print('///////' + data["userName"]);
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات الشخص "),
          backgroundColor: greenColor,
          leading: IconButton(
              onPressed: () {
                navigator!.pop();
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
        ),
        body: verif
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // UrlLauncher.launch('mailto:${p.email}'),
                    Text(" إسم الشخص : ${data["userName"]} ",
                        style: TextStyle(fontSize: 18)),
                    TextButton(
                      onPressed: () {
                        UrlLauncher.launch(
                            'mailto:${Get.arguments["userEmail"]}');
                      },
                      child: Text(
                        "  البريد الإلكتروني  :${data["userEmail"]}",
                        style: TextStyle(fontSize: 18, color: greenColor),
                      ),
                    ),

                    // Text(" رقم هاتف المحامي : ${data["userPhoneNumber"]} ",
                    //     style: TextStyle(fontSize: 18)),

                    TextButton(
                      onPressed: () {
                        // UrlLauncher.launch('tel:+${data["userPhoneNumber"]}');
                        // UrlLauncher.launch("tel://");

                        // launchPhoneDialer(data["userPhoneNumber"]);

                        // UrlLauncher.launch('mailto:${p.email}'),
                        launchPhoneDialer(
                            "${Get.arguments["userPhoneNumber"]}");
                      },
                      child: Text(
                          " رقم هاتف الشخص : ${data["userPhoneNumber"]} ",
                          style: TextStyle(fontSize: 18, color: greenColor)),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // UrlLauncher.launch('mailto:${p.email}'),
                    // Text(" إسم الشخص : ${data["userName"]} ",
                    // style: TextStyle(fontSize: 18)),
                    CircularProgressIndicator(
                      backgroundColor: goldenColor,
                    )
                  ],
                ),
              ));
  }
}
