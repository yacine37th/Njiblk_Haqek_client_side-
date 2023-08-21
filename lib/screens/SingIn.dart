import 'package:avocat/HomeScreen.dart';
import 'package:avocat/main.dart';
import 'package:avocat/screens/SingUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    invertShowPassword();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  var db = FirebaseFirestore.instance;
  Route route = MaterialPageRoute(builder: (context) => HomeScreen());

  Future signInAUser() async {
    Get.defaultDialog(
        onWillPop: () {
          return Future.value();
        },
        barrierDismissible: false,
        title: "يرجى الانتظار",
        content: const CircularProgressIndicator());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      // credential.user!.uid
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
      Get.back();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login avec success")));
      Navigator.pushReplacement(context, route);

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
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: "يرجى مراجعة كلمة المرور",
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "تسجيل الدخول",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Stack(
              children: [
                Column(
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
                                prefixIcon: const Icon(Icons.lock),
                                   hintStyle: TextStyle(
                                        fontFamily: 'Cairo', color: Colors.grey),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      _toggleObscured();
                                    },
                                    icon: _obscured
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                hintText: 'كلمة السر',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      // backgroundColor: MaterialStateProperty.all(
                                      //     Color.fromRGBO(32, 48, 61, 1)),
                                      //     alignment: Alignment.center

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
                                        fontSize: 17, fontFamily: 'Cairo'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: TextButton(
                                  style: ButtonStyle(
                                      // backgroundColor: MaterialStateProperty.all(
                                      //     Color.fromRGBO(32, 48, 61, 1)),
                                      //     alignment: Alignment.center

                                      ),
                                  onPressed: () {
                                    MainFunctions.textDirection =
                                                    TextDirection.rtl;
                                                       Get.forceAppUpdate();
                                                        Get.toNamed("/register");
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => SignUp()),
                                    // );
                                  },
                                  child: const Text(  "إنشاء حساب",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'Cairo'),),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
