import 'package:avocat/Themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvocatHomeScreen extends StatefulWidget {
  const AvocatHomeScreen({super.key});

  @override
  State<AvocatHomeScreen> createState() => _AvocatHomeScreenState();
}

class _AvocatHomeScreenState extends State<AvocatHomeScreen> {
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
      user=currentUser;
    });
     print("user/////////////////");
    print(user.uid);
    // print(currentUser!.uid);
    if (currentUser == null) {
    } else {
      
    }
  }

    var userID =   Get.arguments['userID'] ;
    var test = "dededed";
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('issues')
// user.uid?
      // .where('lawyerID', isEqualTo:"JlU5soCsCwbVRnNdfhJeBixgHBH3")
      .where('lawyerID', isEqualTo:true )
      // .where('isAccepted?', isEqualTo: true)
      // .orderBy("orderDate",descending: true)
      .snapshots();

      final Stream<QuerySnapshot> _usersStream2 = FirebaseFirestore.instance
      .collection('users')
// isAccepted?
      .where('lawyerID', isEqualTo:"JlU5soCsCwbVRnNdfhJeBixgHBH3")
      // .where('isAccepted?', isEqualTo: true)
      // .orderBy("orderDate",descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لائحة المحاميين '),
        backgroundColor: goldenColor,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: goldenColor,
                      )
                    ],
                  ),
                );
                // Text('${snapshot.connectionState}');
              }
              if (snapshot.data!.docs.map == []) {
                return Center(
                  child: Text(
                    "لا يوجد محاميين مسجلين ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: goldenColor ),
                  ),
                );
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
                          Get.toNamed("/lawyerDetails", arguments: data);
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
                        title: Text("${data['lawyerID']}"),
                        subtitle: Text(data["userID"]),
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