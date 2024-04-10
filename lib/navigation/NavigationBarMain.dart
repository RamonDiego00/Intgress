import 'package:flutter/material.dart';
import 'package:intgress/screens/AnnotationPage.dart';
import 'package:intgress/screens/MessagePage.dart';
import 'package:intgress/screens/ResumeGeneralPage.dart';
import 'package:provider/provider.dart';

class NavigationBarMain extends StatefulWidget {
  @override
  _NavigationBarMainState createState() => _NavigationBarMainState();
}

class _NavigationBarMainState extends State<NavigationBarMain> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AnnotationPage(),
    const ResumeGeneralPage(),
    const MessagePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(57, 57, 57, 1),
        showSelectedLabels : false ,
        showUnselectedLabels : false ,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
                Icons.text_snippet),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
                Icons.pie_chart),
          ),
          // BottomNavigationBarItem(
          //   label: "",
          //   icon: Icon(Icons.message_outlined,),
          // ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
