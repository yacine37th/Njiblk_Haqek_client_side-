import 'package:avocat/HomeScreen.dart';
import 'package:avocat/Themes/colors.dart';
import 'package:avocat/main.dart';
import 'package:avocat/screens/SingIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientRegistration extends StatefulWidget {
  const ClientRegistration({super.key});

  @override
  State<ClientRegistration> createState() => _ClientRegistrationState();
}

class _ClientRegistrationState extends State<ClientRegistration> {
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

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
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

  List<String> _locations = [
    'أدرار',
    'الشلف',
    "الأغواط",
    "أم البواقي",
    "باتنة",
    "بجاية",
    "بسكرة",
    "بشار",
    "البليدة",
    "البويرة",
    "تمنراست",
    "تبسة",
    "تلمسان",
    "تيارت",
    "تيزي وزو",
    "الجزائر",
    "الجلفة",
    "جيجل",
    "سطيف",
    "سعيدة",
    "سكيكدة",
    "سيدي بلعباس ",
    "عنابة",
    "قالمة",
    "قسنطينة",
    "المدية",
    "مستغانم",
    "المسيلة",
    "معسكر",
    "ورقلة",
    "وهران",
    "البيض",
    "إليزي",
    "برج بوعريريج",
    "بومرداس",
    "الطارف",
    "تيسمسيلت",
    "الوادي",
    "خنشلة",
    "سوق أهراس",
    "تيبازة",
    "ميلة",
    "عين الدفلة",
    "النعامة",
    "عين تيموشنت",
    "غرداية",
    "غليزان"
  ]; // Option 2
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
        onWillPop: () {
          return Future.value();
        },
        barrierDismissible: false,
        title: "يرجى الانتظار",
        content: const CircularProgressIndicator(
          backgroundColor: goldenColor,
        ));
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // if (_selectedLo  cation == "ensignant") {
      FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set({
        "userID": credential.user!.uid,
        "userType": "باحث محام",
        "userEmail": email.text,
        "userName": username.text,
        // "userWilaya": _selectedLocation,
        "userPhoneNumber": phone.text,
        "isAccepted?": true,
        "issuesID": [],
        "issueAdminID": [],
        // "userCV" : "",
      });
      Get.back();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("تم التسجيل بشكل جيد للغاية ، والآن يرجى تسجيل الدخول  ")));
               await FirebaseAuth.instance.signOut();
      Get.back();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: goldenColor,
        title: Text("إنشاء حساب جديد "),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "من فضلك املأ المعلومات";
                            } else if (val.length < 2) {
                              return "يجب ان يكون أكثر من حرفين";
                            }
                            return null;
                          },
                          controller: username,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: goldenColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))

                                // borderRadius: BorderRadius.circular(25.0),
                                ),
                            prefixIconColor: goldenColor,
                            hintStyle: TextStyle(
                                fontFamily: 'Cairo', color: Colors.grey),
                            // border: OutlineInputBorder(),
                            hintText: " الاسم و اللقب",
                            // labelText: "Entrer votre nom d'utilisateur",
                            prefixIcon: Icon(Icons.person_2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "من فضلك املأ رقم الهاتف";
                            } else if (val.length < 8) {
                              return "يجب أن يكون أكثر من 8 أرقام  ";
                            }
                            return null;
                          },
                          controller: phone,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: goldenColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))

                                // borderRadius: BorderRadius.circular(25.0),
                                ),
                            prefixIconColor: goldenColor,
                            hintStyle: TextStyle(
                                fontFamily: 'Cairo', color: Colors.grey),
                            // border: OutlineInputBorder(),
                            hintText: "رقم الهاتف",
                            // labelText: "Entrer votre nom d'utilisateur",
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                      ),
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
                            hintText: 'البريد الإكتروني',
                            hintStyle: TextStyle(
                                fontFamily: 'Cairo', color: Colors.grey),
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
                              return "من فضلك املأ كلمة السر";
                            }
                            if (value.length > 20) {
                              return "يجب ان يكون اقل من 20 حرف";
                            }
                            if (value.length < 8) {
                              return "يجب ان يكون أكثر من 8 حروف";
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
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _toggleObscured();
                                },
                                color: goldenColor,
                                icon: _obscured
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            hintText: 'كلمة السر',
                            hintStyle: TextStyle(
                                fontFamily: 'Cairo', color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(greenColor),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              createNewUser();
                            }
                          },
                          child: const Text(
                            "إنشاء حساب",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Cairo',
                                color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
