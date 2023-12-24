import 'package:flutter/material.dart';
import 'package:intgress/screens/AnnotationPage.dart';
import 'package:intgress/screens/InsigthsPage.dart';
import 'package:intgress/screens/MessagePage.dart';

import 'navigation/NavigationBarMain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intgress',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            background: Colors.black,
            primary: const Color.fromRGBO(257, 257, 257, 1)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarMain(),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          AnnotationPage(),
          InsigthsPage(),
          MessagePage(),
        ],
      ),
    );
  }
}
