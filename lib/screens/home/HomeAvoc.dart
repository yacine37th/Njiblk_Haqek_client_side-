
import 'package:avocat/Themes/colors.dart';
import 'package:avocat/screens/home/AvocatHomeScreen.dart';
import 'package:avocat/screens/home/AvocatSending.dart';
import 'package:flutter/material.dart';

class HomeAvoc extends StatefulWidget {
  const HomeAvoc({super.key});

  @override
  State<HomeAvoc> createState() => _HomeAvocState();
}

class _HomeAvocState extends State<HomeAvoc> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Subscription',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    AvocatHomeScreen(),
    AvocatSending(),
  ];
  static const IconData subscriptions =
      IconData(0xe618, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
                    // selectedItemColor: goldenColor,

        // selectedIconTheme:  IconThemeData(
        //   color:  Color.fromRGBO(32, 48, 61, 1),

        // ),

        // unselectedIconTheme: IconThemeData(
        //   color:  Colors.blackS

        // ),
        // selectedIconTheme: IconThemeData(color: Colors.red),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home, color: goldenColor),

            label: "المحاميين",
            backgroundColor: goldenColor
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search, color: goldenColor),

            icon: Icon(Icons.search),
            label: "الأشخاص الباحثين عن محامي",
            
            // backgroundColor: Colors.green,
          ),
         
         
          // BottomNavigationBarItem(
          //                           activeIcon:Icon(Icons.table_chart , color: goldenColor) ,

          //   icon: Icon(Icons.table_chart),
          //   label: "الرئيسية",
          //   // backgroundColor: Colors.purple,
          // ),
          // BottomNavigationBarItem(
          //               activeIcon:Icon(Icons.person_2 , color: goldenColor) ,

          //   // icon: Icon(Icons.settings),
          //   // label: 'Settings',
          //   icon: Icon(Icons.person_2),
          //   label: "حسابي",
          //   // backgroundColor: Colors.pink,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: greenColor,
        // unselectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
      body: screens[_selectedIndex],
    );
  }
}
