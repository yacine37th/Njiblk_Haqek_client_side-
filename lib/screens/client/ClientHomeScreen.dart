import 'package:avocat/Themes/colors.dart';
import 'package:avocat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
   bool isLogin = false;
    var data;
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
        });
        print(user.uid);
        // FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(user.uid)
        //     .get()
        //     .then((snapshot) {
        //   // Use ds as a snapshot
        //   setState(() {
        //     // data2 = snapshot.data()!;
        //     // print("dddd///////////////" + data2["userType"]);
        //     // if(data2["userType"] =="باحث محام") {
        //     //   isLogin = true;
        //     // }
        //   });

        // });
   
      }
    });
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: greenColor,
        title: Text("الصفحة الرئيسية"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout , color: whiteColor,),
            color: greenColor,
            tooltip: 'تسجيل الخروج',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
                   Get.offAllNamed("/home");
              //  Navigator.of(context).pop();
              
            },
          ),
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TextButton(onPressed: ()async{
            //   await FirebaseAuth.instance.signOut();
            // }, child: Text("logout")),
            TextButton(
              onPressed: () {
                MainFunctions.textDirection = TextDirection.rtl;
                Get.forceAppUpdate();
                Get.toNamed("/findLawyer",arguments: data  );
              },
              child: Text(
                "إبحث عن محامي  ",
                style: TextStyle(color: whiteColor, fontSize: 18),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(greenColor)),
            ),
            const SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () {
               Get.toNamed("/issuesForm");
              },
              child: Text(
                " كلفنا بالبحث عن محامي  ",
                style: TextStyle(color: whiteColor, fontSize: 18),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(greenColor)),
            ),
          ],
        ),
      ),
    );
  }
}
