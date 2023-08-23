import 'dart:io';

import 'package:avocat/Home.dart';
import 'package:avocat/HomeScreen.dart';
import 'package:avocat/firebase_options.dart';
import 'package:avocat/screens/client/ClientHomeScreen.dart';
import 'package:avocat/screens/client/FindLawyer.dart';
import 'package:avocat/screens/client/IssuesForm.dart';
import 'package:avocat/screens/client/LawyerDetails.dart';
import 'package:avocat/screens/home/AvocatHomeScreen.dart';
import 'package:avocat/screens/home/AvocatRegisterInfo.dart';
import 'package:avocat/screens/client/ClientLogin.dart';
import 'package:avocat/screens/client/ClientRegistration.dart';
import 'package:avocat/screens/home/Avocat.dart';
import 'package:avocat/screens/home/AvocatRegister.dart';
import 'package:avocat/screens/home/AvocatSending.dart';
import 'package:avocat/screens/home/AvocatSendingDetails.dart';
import 'package:avocat/screens/home/HomeAvoc.dart';
import 'package:avocat/screens/home/Personsdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var user = FirebaseAuth.instance.currentUser;
  var data;
  bool de = false;
  bool isLogin = false;
  bool login = false;
  Future islog() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        print(isLogin);
//       Navigator.pushReplacement(
// context,MaterialPageRoute(builder: (context) => SingIn()),);
// Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        print('User is signed in!');
        setState(() {
          isLogin = true;
        });
        print(user.uid);
        print(isLogin);
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
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Avocat',
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      textDirection: MainFunctions.textDirection,

      // defaultTransition: Transition.cupertino,
      // theme: Themes.customLightTheme,
      // textDirection: MainFunctions.textDirection,
      // home: HomeScreen() ,
      //     ? HomeScreen()
      //     // de
      //     //     ? HomeEtudiant()
      //     //     : HomeEnsi()
      //     : SingIn(),
      initialRoute: "/home",
      getPages: [
        GetPage(
          name: "/homee",
          page: () => const Home(),
        ),
        GetPage(
          name: "/home",
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: "/avocatHome",
          page: () => const AvocatHomeScreen(),
        ),



         GetPage(
          name: "/avocatAvoc",
          page: () => const HomeAvoc(),
        ),


         GetPage(
          name: "/avocatSendingDetails",
          page: () => const AvocatSendingDetails(),
        ),
        
          GetPage(
          name: "/avocatLogin",
          page: () => const Avocat(),
        ),
         GetPage(
          name: "/avocatRegister",
          page: () => const AvocatRegister(),
        ),
         GetPage(
          name: "/avocatRegisterInfo",
          page: () => const AvocatRegisterInfo(),
        ),


GetPage(
          name: "/person",
          page: () => const PersonDetails(),
        ),

        GetPage(
          name: "/clientLogin",
          page: () => const ClientLogin(),
        ),
          GetPage(
          name: "/clientRegister", 
          page: () => const ClientRegistration(),
        ),
         GetPage(
          name: "/clientHome",
          page: () => const ClientHomeScreen(),
        ),
         GetPage(
          name: "/issuesForm",
          page: () => const IssuesForm(),
        ),
        GetPage(
          name: "/findLawyer",
          page: () => const FindLawyer(),
        ),
        GetPage(name: "/lawyerDetails", page: ()=>  LawyerDetails())
        // GetPage(
        //   name: "/register",
        //   page: () => const SignUp(),
        // ),
        // GetPage(
        //   name: "/login",
        //   page: () => const SingIn(),
        // ),
      ],
      // initialRoute:  isLogin ? "/home" : "/login"
      // initialRoute: isLogin ? "/home" :
      //  "/login",

      // if(isLogin==false){
      //   return "/login"
      // }else {
      //   return  "/home"
      // };
    );
  }
}

class MainFunctions {
  // static intl.DateFormat dateFormat = intl.DateFormat('yyyy-MM-dd');
  //String? ddd = MainFunctions.dateFormat.format(DateTime.now());

  static TextDirection? textDirection = TextDirection.rtl;
  static File? pickedImage;
  // static Color generatePresizedColor(int namelength) {
  //   return profilColors[((namelength - 3) % 8).floor()];
  // }

  // static getcurrentUserInfos() async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(currentUser!.uid)
  //       .get()
  //       .then(
  //     (value) async {
  //       bool tempIsSubbed = false;
  //       print(value["userMaktabati"]);
  //       currentUserInfos = UserModel(
  //         uID: value["userID"],
  //         email: value["userEmail"],
  //         firstName: value["userFirstName"],
  //         lastName: value["userLastName"],
  //         aboutMe: value["userAboutMe"],
  //         imageURL: value["userImageURL"],
  //         favoriteBooks: value["userFavoriteBooks"],
  //         maktabati: value["userMaktabati"],
  //         facebookAccount: value["userFacebookAccount"],
  //         i9ama: value["userI9ama"],
  //         instaAccount: value["userInstaAccount"],
  //         ordersElectronicBooks: value["userOrdersElectronicBooks"],
  //       );
  //       if (value.data()!.containsKey("userIsSubbed")) {
  //         currentUserInfos.isSubbed = value["userIsSubbed"];
  //         if (currentUserInfos.isSubbed) {
  //           print(value["userSubEndingingDay"]);
  //           currentUserInfos.subStartingDay = dateFormat.format(DateTime.parse(
  //               value["userSubStartingDay"].toDate().toString()));
  //           currentUserInfos.subEndingingDay = dateFormat.format(DateTime.parse(
  //               value["userSubEndingingDay"].toDate().toString()));
  //         }
  //       }
  //     },
  //   );
  //   print(currentUserInfos.imageURL);
  //   print("/////////////////");
  // }

  // static successSnackBar(String text) {
  //   if (!Get.isSnackbarOpen) {
  //     Get.rawSnackbar(
  //         isDismissible: true,
  //         duration: const Duration(seconds: 3),
  //         messageText: Text(
  //           text,
  //           style: const TextStyle(fontSize: 16, color: whiteColor),
  //         ),
  //         backgroundColor: const Color.fromARGB(255, 98, 216, 102),
  //         showProgressIndicator: true,
  //         snackPosition: SnackPosition.TOP,
  //         icon: const Icon(
  //           Icons.done,
  //           color: whiteColor,
  //         ));
  //   }
  // }

  // static somethingWentWrongSnackBar([String? errorText]) {
  //   if (!Get.isSnackbarOpen) {
  //     Get.rawSnackbar(
  //         duration: const Duration(seconds: 5),
  //         messageText: Text(
  //           errorText ?? "هناك خطأ ما",
  //           style: const TextStyle(fontSize: 16, color: whiteColor),
  //         ),
  //         showProgressIndicator: true,
  //         snackPosition: SnackPosition.TOP,
  //         icon: const Icon(
  //           Icons.report_problem,
  //           color: redColor,
  //         ));
  //   }
  // }


}
