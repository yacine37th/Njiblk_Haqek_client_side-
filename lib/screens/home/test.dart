import 'package:avocat/Themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              'data',
              style: TextStyle(color: whiteColor),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(greenColor),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('data'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(goldenColor)),
          ),
          Text("Home"),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text('Logout'))
        ],
      )),
    );
  }
}

//  greenColor: #083230
// goldenColor : #c87e41