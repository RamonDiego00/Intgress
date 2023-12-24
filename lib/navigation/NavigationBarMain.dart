import 'package:flutter/material.dart';

class NavigationBarMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(57, 57, 57, 1),
      selectedItemColor: const Color.fromRGBO(257, 257, 257, 1),
      currentIndex: _selectedIndex,
      unselectedItemColor: const Color.fromRGBO(257, 257, 257, 0.5),
      items: const [
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.text_snippet, color: Color.fromRGBO(257, 257, 257, 1)),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.pie_chart, color: Color.fromRGBO(257, 257, 257, 1)),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.message_outlined,
              color: Color.fromRGBO(257, 257, 257, 1)),
        ),
      ],
      onTap: (int index) {
        _onItemTapped(index);
      },
    );
  }

  late int _selectedIndex;

  NavigationBarMain({super.key}) {
    _selectedIndex = 0;
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
  }
}
