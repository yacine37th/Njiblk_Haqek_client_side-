import 'package:avocat/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart ' as UrlLauncher;

class AvocatSendingDetails extends StatefulWidget {
  const AvocatSendingDetails({super.key});

  @override
  State<AvocatSendingDetails> createState() => _AvocatSendingDetailsState();
}

class _AvocatSendingDetailsState extends State<AvocatSendingDetails> {
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
        // ذ
        title: Text('معلومات الشخص       '),
        backgroundColor: goldenColor,
        leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    " الإسم الكامل للشخص : ${Get.arguments["userName"]} ",
                    style: TextStyle(fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  UrlLauncher.launch('mailto:${Get.arguments["userEmail"]}');
                },
                child: Text(
                  "  البريد الإلكتروني  :${Get.arguments["userEmail"]}",
                  style: TextStyle(fontSize: 18, color: greenColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  // UrlLauncher.launch('tel:+${Get.arguments["userPhoneNumber"]}');
                  // UrlLauncher.launch("tel://");

                  launchPhoneDialer(Get.arguments["userPhoneNumber"]);

                  // UrlLauncher.launch('mailto:${p.email}'),
                },
                child: Text(
                    " رقم هاتف الشخص : ${Get.arguments["userPhoneNumber"]} ",
                    style: TextStyle(fontSize: 18, color: greenColor)),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("نوع النزاع : ${Get.arguments['issueType']}",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              // issueContent
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("وقائع النزاع : ${Get.arguments['issueContent']}",
                    style: TextStyle(fontSize: 18, color: greenColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
