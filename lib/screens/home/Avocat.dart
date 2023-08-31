import 'package:avocat/HomeScreen.dart';
import 'package:avocat/Themes/colors.dart';
import 'package:avocat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Avocat extends StatefulWidget {
  const Avocat({super.key});

  @override
  State<Avocat> createState() => _AvocatState();
}

class _AvocatState extends State<Avocat> {
  late AnimationController _controller;

  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  invertShowPassword() {
    showPassword = !showPassword;
  }

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

  // @override
  // void initState() {
  //   super.initState();
  //   // _controller = AnimationController(vsync: this);
  //   invertShowPassword();
  // }
  Future Lougout() async {
    await FirebaseAuth.instance.signOut();
  }

  var currentUser;
  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
    invertShowPassword();
    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;
    });
    // print(currentUser!.uid);
    if (currentUser == null) {
    } else {
      // Get.defaultDialog(
      // onWillPop: () {
      //   return Future.value();
      // },
      // barrierDismissible: false,
      // title: "يرجى الانتظار",
      // content: const CircularProgressIndicator(
      //   backgroundColor: goldenColor,
      // ));
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .then((snapshot) {
        // Use ds as a snapshot
        setState(() {
          data = snapshot.data()!;
          print('Values from db /////////////////////////////////: ' +
              data["userType"]);
          if (data["userType"] == "محامي" && data["isAccepted?"] == true) {
            // MainFunctions.textDirection = TextDirection.rtl;
            // Get.forceAppUpdate();
            Get.back();
            Get.offAllNamed("/avocatAvoc", arguments: data);
          } else {
            Get.back();

            Lougout();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  var db = FirebaseFirestore.instance;
  Route route = MaterialPageRoute(builder: (context) => HomeScreen());
  bool isVerified = false;
  bool islawyer = false;

  var data;

  Future signInAUser() async {
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
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      // credential.user!.uid
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
      //    FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(credential.)
      //     .get()
      //     .then((snapshot) {
      //   // Use ds as a snapshot
      //   setState(() {
      //     usercurrent = snapshot.data()!;
      //     // print('Values from db /////////////////////////////////: ' +
      //     //     data["TypeUser"]);
      //     //  user = snapshot.data()!;
      //   });

      //   // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
      // });
      print(" //////////////////////////// credential");
      print(credential.user!.uid);
      FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .get()
          .then((snapshot) {
        // Use ds as a snapshot
        setState(() {
          data = snapshot.data()!;
          isVerified = data["isAccepted?"];
        });
        if (data["userType"] == "محامي") {
          if (isVerified == false) {
            Get.defaultDialog(
                backgroundColor: goldenColor,
                barrierDismissible: false,
                title: "   يرجى الإنتظار حتى يتم قبولك ",
                titleStyle: TextStyle(color: whiteColor),
                content: ElevatedButton(
                  onPressed: () async {
                    Get.back();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(greenColor),
                  ),
                  child: Text(
                    'حسنا',
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Cairo', color: whiteColor),
                  ),
                ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("تسجيل الدخول تم بنجاح ")));
            Get.offAllNamed("/avocatAvoc");
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("أنت لست محامي من فضلك سجل بحساب المحامي")));
        }

        //  user = snapshot.data()!;

        // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
      });
      print(isVerified);
      Get.back();

      print('////////////////////////////////////// DONE');

      // Get.defaultDialog(
      //   barrierDismissible: false,
      //   title: "Please wait",
      //   content: const Text("Login Success"),
      //   onConfirm: () {
      //     Get.back();
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'user-not-found') {
        Get.defaultDialog(
            title: "حساب غير موجود",
            content: ElevatedButton(
              onPressed: () async {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(greenColor),
              ),
              child: Text(
                'حسنا',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Cairo', color: whiteColor),
              ),
            )

            // content: const Icon(
            //   Icons.report_problem,
            //   color: Colors.red,
            // ),
            // onConfirm: () {
            //   Get.back();
            // },
            );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
            title: "يرجى مراجعة كلمة المرور",
            content: ElevatedButton(
              onPressed: () async {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(greenColor),
              ),
              child: Text(
                'حسنا',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Cairo', color: whiteColor),
              ),
            )

            // content: const Icon(
            //   Icons.report_problem,
            //   color: Colors.red,
            // ),
            // onConfirm: () {
            //   Get.back();
            // },
            );
      }
    } catch (e) {
      print(e);
      Get.back();
      Get.defaultDialog(
        title: "يوجد خطأ ما",
        content: const Icon(
          Icons.report_problem,
          color: Colors.red,
        ),
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: greenColor,
        title: Text("تسجيل الدخول"),
        leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "من فضلك املأ البريد الإلكتروني";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(val)) {
                            return "من فضلك املأ بريد إلكتروني صحيح";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: goldenColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))

                              // borderRadius: BorderRadius.circular(25.0),
                              ),
                          prefixIconColor: goldenColor,
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          hintStyle: TextStyle(
                              fontFamily: 'Cairo', color: Colors.grey),
                          hintText: 'البريد الإكتروني',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscured,
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "من فضلك املأ كلمة المرور";
                          }
                          if (value.length > 20) {
                            return " كلمة المرور لا يمكن أن تتجاوز 20 حرفًا";
                          }
                          if (value.length < 8) {
                            return "كلمة المرور لا يمكن أن تكون أقل من 8 أحرف";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: goldenColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))
                              // borderRadius: BorderRadius.circular(25.0),
                              ),
                          prefixIconColor: goldenColor,
                          prefixIcon: const Icon(Icons.lock),
                          hintStyle: TextStyle(
                              fontFamily: 'Cairo', color: Colors.grey),
                          suffixIcon: IconButton(
                              onPressed: () {
                                _toggleObscured();
                              },
                              color: goldenColor,
                              icon: _obscured
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          hintText: 'كلمة السر',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: TextButton(
                            style: ButtonStyle(
                              // backgroundColor: MaterialStateProperty.all(
                              //     Color.fromRGBO(32, 48, 61, 1)),
                              //     alignment: Alignment.center

                              backgroundColor:
                                  MaterialStateProperty.all(greenColor),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signInAUser();
                                //          Navigator.pushAndRemoveUntil(
                                //   context,
                                //   MaterialPageRoute(builder: (context) =>),
                                //   (Route<dynamic> route) => false,
                                // );
                              }
                            },
                            child: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Cairo',
                                  color: whiteColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: TextButton(
                            style: ButtonStyle(
                                // backgroundColor: MaterialStateProperty.all(
                                //     Color.fromRGBO(32, 48, 61, 1)),
                                //     alignment: Alignment.center

                                ),
                            onPressed: () {
                              MainFunctions.textDirection = TextDirection.rtl;
                              Get.forceAppUpdate();
                              Get.toNamed("/avocatRegister");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => SignUp()),
                              // );
                            },
                            child: const Text(
                              "إنشاء حساب",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Cairo',
                                  color: goldenColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
