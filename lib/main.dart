import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intgress/core/repository/NoteRepository.dart';
import 'package:intgress/screens/AnnotationPage.dart';
import 'package:intgress/screens/FillNotePage.dart';
import 'package:intgress/screens/LoginPage.dart';
import 'package:intgress/screens/NotificationPage.dart';
import 'package:intgress/screens/MessagePage.dart';
import 'package:intgress/screens/ResumeGeneralPage.dart';
import 'package:intgress/viewmodel/NoteViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';
import 'navigation/NavigationBarMain.dart';
import 'navigation/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sqfliteFfiInit();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteRepository()),
      ChangeNotifierProvider(create: (context) => NoteViewModel(NoteRepository()))
    ],
    child: MyApp(),
  ));
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
      home: const LoginPage(),
      onGenerateRoute: router.generator,
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
          MessagePage(),
          FillNotePage(),
          ResumeGeneralPage()
        ],
      ),
    );
  }
}
