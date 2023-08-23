import 'package:avocat/Themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IssuesForm extends StatefulWidget {
  const IssuesForm({super.key});

  @override
  State<IssuesForm> createState() => _IssuesFormState();
}

class _IssuesFormState extends State<IssuesForm> {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final issueContent = TextEditingController();
  final username= TextEditingController();
  final phone= TextEditingController();
  final email= TextEditingController();
  final issue= TextEditingController();
  
  // 
  var currentUser;
  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);

    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;
    });

    print(currentUser!.uid);
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(currentUser!.uid)
    //     .get()
    //     .then((snapshot) {
    //   // Use ds as a snapshot
    //   setState(() {
    //     data = snapshot.data()!;
    //     print('Values from db /////////////////////////////////: ' +
    //         data["userType"]);
    //     if (data["userType"] == "باحث محام") {
    //       MainFunctions.textDirection = TextDirection.rtl;
    //       Get.forceAppUpdate();
    //       Get.offAllNamed("/clientHome");
    //     }else {
    //          ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: const Text("تم حفظ طلبك بنجاح إنتظر رد المحامي ")));
    //     }
    //   });
    // });
  }

  Future submit() async {
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
    print(issueContent.text);
    try {
      print(currentUser!.uid);
      print("dedededed/////////////");
      var doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid);
          var dcoissue = await FirebaseFirestore.instance
          .collection("adminissue")
          .doc();
      doc.update({
        "issueAdminID": FieldValue.arrayUnion([dcoissue.id]),
      });
      dcoissue.set({
        "issueID" : dcoissue.id,
         "userEmail": email.text,
        "userName": username.text,
        "userWilaya": _selectedLocation,
        "userPhoneNumber": phone.text,
        "userID":doc.id,
        "issueType" : issue.text , 
        "issueContent" :issueContent.text, 
      });
      print("dedededed/////////////////2");

      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text("تم حفظ قضيتك بنجاح إنتظر رد المحامي ")));
      Get.back();
    } catch (e) {
      print(e);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: goldenColor,
        title: Text('معلومات المشكلة'),
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
                    // crossAxisAlignment: CrossAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisSize: MainAxisSize.min,
        
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          child: DropdownButton(
                            hint: Text("ولايةالتي تقيم فيها"),
                            // Text("ولاية ال\\"), // Not necessary for Option 1
                            value: _selectedLocation,
        
                            onChanged: (newValue) {
                              setState(() {
                                _selectedLocation = newValue;
                              });
                            },
                            //  validator: (value) =>
                            //       value == null ? 'Select the Category of the book' : null,
        
                            items: _locations.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      
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
                            controller: issue,
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
                              hintText: "  نوع النزاع",
                              // labelText: "Entrer votre nom d'utilisateur",
                              prefixIcon: Icon(Icons.sd_card_alert_rounded),
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
                              return "من فضلك املأ المعلومات";
                            } else if (val.length < 2) {
                              return "يجب ان يكون أكثر من حرفين";
                            }
                            return null;
                          },
                          controller: issueContent,
                          minLines: 3,
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
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
                            hintText: " أدخل وقائع النزاع  ...  ",
                            prefixIcon:Icon(Icons.handshake)
                            //  SizedBox(
                            //   height: 5,
                            //   width: 5,
                            //   child: 
                            //   Image.asset(
                            //     "assets/images/edit-editor-pen-pencil-write-icon--4 (1).png",
                            //     fit: BoxFit.cover,
                            //     width: 5,
                            //     height: 5,
                            //   ),
                            // )
                            ,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                         padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(greenColor),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              submit();
                              // signInA;User();
                              //          Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(builder: (context) =>),
                              //   (Route<dynamic> route) => false,
                              // );
                            }
                          },
                          child: const Text(
                            "حفظ القضية ",
                            style: TextStyle(fontSize: 17, fontFamily: 'Cairo'),
                          ),
                        ),
                      ),
        
                      //naw3 nize3 
                  
                      // 
                      // 
                      //
                      //wa9ai3 niza3 (3ard moufasel lel niza3 
                      // kayfiyet tawasol m3ana woula m3a mouhami 
        
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
