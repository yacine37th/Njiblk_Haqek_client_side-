import 'package:avocat/Themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendingFromAdmin extends StatefulWidget {
  const SendingFromAdmin({super.key});

  @override
  State<SendingFromAdmin> createState() => _SendingFromAdminState();
}

class _SendingFromAdminState extends State<SendingFromAdmin> {
  var currentUser;
  var user;
  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;
    });
    setState(() {
      user = currentUser;
    });
    print("user/////////////////");

    // print(currentUser!.uid);
    if (user == null) {
    } else {
      print(user.uid);
    }
  }

  // var userID =   Get.arguments['userID'] ;
  var test = "dededed";
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('adminissue')
// user.uid?
      .where('lawyerID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      // .where('lawyerID', isEqualTo:true )
      // .where('isAccepted?', isEqualTo: true)
      // .orderBy("orderDate",descending: true)
      .snapshots();

//       final Stream<QuerySnapshot> _usersStream2 = FirebaseFirestore.instance
//       .collection('users')
// // isAccepted?
//       .where('lawyerID', isEqualTo:"JlU5soCsCwbVRnNdfhJeBixgHBH3")
//       // .where('isAccepted?', isEqualTo: true)
//       // .orderBy("orderDate",descending: true)
//       .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ذ
        title: Text('قائمة الأشخاص   '),
        backgroundColor: goldenColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
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
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: goldenColor,
                      )
                    ],
                  ),
                );
                // Text('${snapshot.connectionState}');
              }
              // if (snapshot.data!.docs.map == []) {
              //   return Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "لا يوجد محاميين مسجلين ",
              //           style: TextStyle(
              //               fontSize: 25,
              //               fontWeight: FontWeight.bold,
              //               color: goldenColor ),
              //         ),
              //       ],
              //     ),
              //   );
              // }
              if (snapshot.data == []) {
                return Center(child: Text('No Patients'));
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ListTile(
                        trailing: Icon(Icons.arrow_back_outlined),
                        onTap: () {
                          Get.toNamed("/person", arguments: data);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LawyerDetails(
                          //               test: data,
                          //             )));
                          //                  FileDownloader.downloadFile(
                          // url:data["emploiPic"],
                          // onProgress: (name, progress) {
                          //   setState(() {
                          //     // _progress = progress;
                          //   });
                          // },
                          // onDownloadCompleted: (value) {
                          //   print('path  $value ');
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       content: Text("Dowload Complete ${value}")));
                          //   setState(() {
                          //     // _progress = null;
                          //   });
                          // },
                          // onDownloadError: (String error) {
                          //   print('DOWNLOAD ERROR: $error');
                          // });
                        },
                        title: Text("شخص أرسل طلب من أجل  التواصل"),
                        // subtitle: Text(data["userID"]),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
