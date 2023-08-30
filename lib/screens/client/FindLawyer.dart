import 'package:avocat/Themes/colors.dart';
import 'package:avocat/screens/client/LawyerDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindLawyer extends StatefulWidget {
  const FindLawyer({super.key});

  @override
  State<FindLawyer> createState() => _FindLawyerState();
}

class _FindLawyerState extends State<FindLawyer> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
// isAccepted?
      .where('userType', isEqualTo: "محامي")
      .where('isAccepted?', isEqualTo: true)
      // .orderBy("orderDate",descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لائحة المحاميين '),
        backgroundColor: greenColor,
          leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon:
            Icon(Icons.arrow_back_ios_rounded)
            ),
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
              if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "لا يوجد محاميين مسجلين ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: goldenColor),
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
                        title: Row(
                          children: [
                             SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          "assets/images/lawyer.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                            Text("${data['userName']}"),
                          ],
                        ),
                        subtitle: Text(data["userEmail"]),
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
