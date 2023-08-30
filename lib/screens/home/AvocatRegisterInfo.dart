import 'dart:io';

import 'package:avocat/HomeScreen.dart';
import 'package:avocat/Themes/colors.dart';
import 'package:avocat/main.dart';
import 'package:avocat/screens/SingIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';

class AvocatRegisterInfo extends StatefulWidget {
  const AvocatRegisterInfo({super.key});

  @override
  State<AvocatRegisterInfo> createState() => _AvoctaRegisteInforState();
}

class _AvoctaRegisteInforState extends State<AvocatRegisterInfo> {
  late AnimationController _controller;
  // final SignUpController signUpController = Get.find();

  final authorName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();

  final bookTitle = TextEditingController();
  final bookCategory = TextEditingController();
  final bookAbout = TextEditingController();
  var bookPrice = TextEditingController();
  final bookPublishingHouse = TextEditingController();
  final bookAuthorName = TextEditingController();
  var category;
  var bookauthorID;
  var bookauhorName;
  final _formKey = GlobalKey<FormState>();
  var _selectedValue;
  var _selectedValueAuth;
  var usercurrent;
  var data;
  Future islog() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        // setState(() {
        //   isLogin = false;
        // });
        // print(isLogin);
//       Navigator.pushReplacement(
// context,MaterialPageRoute(builder: (context) => SingIn()),);
// Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        print('//////////////////// User is signed in!');
        // setState(() {
        //   isLogin = true;
        // });

        print(user.uid);

        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((snapshot) {
          // Use ds as a snapshot
          setState(() {
            usercurrent = snapshot.data()!;
            // print('Values from db /////////////////////////////////: ' +
            //     data["TypeUser"]);
            //  user = snapshot.data()!;
          });

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

  @override
  void dispose() {
    authorName.dispose();
    bookTitle.dispose();
    bookCategory.dispose();
    bookAbout.dispose();
    bookPrice.dispose();
    bookPublishingHouse.dispose();
    bookAuthorName.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();
    super.dispose();
  }

  PlatformFile? pickFile;
  UploadTask? uploadTask;
  UploadTask? uploadTask2;
  File? categorieImage;
  File? bookImage;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickFile = result.files.first;
    });
  }

  var _selectedLocation;
  bool _obscureText = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _obscured = true;
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  var db = FirebaseFirestore.instance;
  Route route = MaterialPageRoute(builder: (context) => SingIn());

  Future createNewUser() async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "يرجى الانتظار",
      content: const CircularProgressIndicator(
        backgroundColor: goldenColor,
      ),
      //  onConfirm: () {
      //     Get.back();
      //   },
    );
    try {
      final path = 'cv/${usercurrent["userID"]}';
      final file = File(pickFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask!.whenComplete(() => {});

      final CVurl = await snapshot.ref.getDownloadURL();
      // final credential =
      //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: email.text,
      //   password: password.text,
      // );

      // if (_selectedLo  cation == "ensignant") {

      FirebaseFirestore.instance
          .collection("users")
          .doc(usercurrent["userID"])
          .update({
        // "userID": credential.user!.uid,
        "userCV": CVurl,
      });
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              " تم تحميل السيرة الداتية بنجاح  ، والآن يرجى   إنتظار قبول ")));
      Get.defaultDialog(
          backgroundColor: goldenColor,
          barrierDismissible: false,
          title: "لقد تم تسجيلك يرجى الإنتظار حتى يتم قبولك  ",
          titleStyle: TextStyle(color: whiteColor),
          content: ElevatedButton(
            onPressed: () async {
              // Get.defaultDialog(
              //   barrierDismissible: false,
              //   title: "يرجى الانتظار",
              //   content: const CircularProgressIndicator(
              //     backgroundColor: goldenColor,
              //   ),
              //   //  onConfirm: () {
              //   //     Get.back();
              //   //   },
              // );
         
              await FirebaseAuth.instance.signOut();

              // Get.back();
              // Get.offAllNamed("/avocatLogin");
              // Get.off("/avocatLogin");

              Get.back();

              Get.back();
              Get.back();
              // Get.back();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(greenColor),
            ),
            child: Text(
              'حسنا',
              style: TextStyle(
                  fontSize: 17, fontFamily: 'Cairo', color: whiteColor),
            ),
          ));

      // Get.defaultDialog(
      //     title: "Votre compte a ete bien créé",
      //     onConfirm: () {
      //       Get.back();
      //     });
      // Navigator.of(context).pop();
      // } else {
      //   FirebaseFirestore.instance
      //       .collection("users")
      //       .doc(credential.user!.uid)
      //       .set({
      //     "userID": credential.user!.uid,
      //     "userEmail": email.text,
      //     "userName": username.text,
      //     "userType": _selectedLocation,
      //     // "nombreAbsence": "",
      //     // "note" : "",
      //     // "traivailsIDS":[],
      //     // "justificationValid?" : false,
      //   });
      //   Get.back();
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text("Inscription a été trés bien fait")));
      //   Navigator.of(context).pop();
      // }
      // await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      // Get.toNamed("/EmailVerification");
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'weak-password') {
        Get.defaultDialog(
          title: "كلمة السر ضعيف، يرجى تغييرها",
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
          title: "يوجد حساب يستعمل هذا البريد الإكتروني",
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      Get.back();
    }
  }

  static List<String> selectedOptions = [];
  bool shouldDisplay2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: greenColor,
        title: Text(" تحميل السيرة الداتية"),
         leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon:
            Icon(Icons.arrow_back_ios_rounded)
            ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(32, 48, 61, 1))),
                  onPressed: selectFile,
                  child: const Text('تحميل السيرة الداتية'),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      " سيدي المحامي سنضع التطبيق في خدمتك مقابل مبلغ مالي ، على أن تتحدد  قيمة المقابل المالي وطريقة الدفع لاحقا ",
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset(
                    "assets/images/contract-icon-10.png",
                    fit: BoxFit.cover,
                  ),
                ),

                // CheckboxListTile(
                //   title: Text('أوافق على الشروط'),
                //   value: selectedOptions.contains('أوافق'),
                //   onChanged: (bool? value) {
                //     setState(() {
                //       if (value!) {
                //         selectedOptions.add('Book Or Picture');
                //         shouldDisplay2 = true;
                //       } else {
                //         selectedOptions.remove('Book Or Picture');
                //         shouldDisplay2 = false;
                //       }
                //     });
                //   },
                // ),
                // // const SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: TextButton(
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(greenColor),
                //     ),
                //     onPressed: () {
                //       // if (pickFile != null) {
                //       //   createNewUser();
                //       //   //          Navigator.pushAndRemoveUntil(
                //       //   //   context,
                //       //   //   MaterialPageRoute(builder: (context) =>),
                //       //   //   (Route<dynamic> route) => false,
                //       //   // );
                //       // }
                //       Get.off("/avocatLogin");
                //     },
                //     child: const Text(
                //       " متابعة",
                //       style: TextStyle(
                //           fontSize: 17, fontFamily: 'Cairo', color: whiteColor),
                //     ),
                //   ),
                // ),

                // GestureDetector(
                //   onTap: () {
                //     //  Get.off("/avocatLogin");
                //     //  Get.to("/avocatLogin");
                //     Get.back();
                //     Get.back();
                //   },
                //   child: Text("deded"),
                // ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(greenColor),
                    ),
                    onPressed: () {
                      if (pickFile != null) {
                        createNewUser();
                        //          Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>),
                        //   (Route<dynamic> route) => false,
                        // );
                      }
                      // Get.off("/avocatLogin");
                    },
                    child: const Text(
                      " متابعة",
                      style: TextStyle(
                          fontSize: 17, fontFamily: 'Cairo', color: whiteColor),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
