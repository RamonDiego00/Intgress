import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intgress/core/repository/NoteRepository.dart';
import 'package:intgress/screens/AnnotationPage.dart';
import 'package:intgress/screens/FillNotePage.dart';
import 'package:intgress/screens/LoginPage.dart';
import 'package:intgress/screens/NotificationPage.dart';
import 'package:intgress/screens/MessagePage.dart';
import 'package:intgress/screens/RegisterPage.dart';
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
      ChangeNotifierProvider(
          create: (context) => NoteViewModel(NoteRepository()))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarDividerColor: Colors.black,
          systemNavigationBarColor: Color.fromRGBO(57, 57, 57, 1),
        ));
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // User is logged in, show NavigationBarMain
          return MaterialApp(
            theme: ThemeData(
              bottomAppBarTheme:BottomAppBarTheme(color: Colors.black54),
              textTheme: const TextTheme(
                headlineLarge: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                titleLarge: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
                bodyMedium: TextStyle(
                  fontSize: 14.0,


                ),
              ),
              useMaterial3: true,
              primaryColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.white,
                  background: Colors.black,
                  brightness: Brightness.dark,
                  primary: Colors.white),
            ),
            home: NavigationBarMain(),
            onGenerateRoute: router.generator,
          );
        } else {
          // User is not logged in, show LoginPage
          return MaterialApp(
            theme: ThemeData(
                bottomAppBarTheme:BottomAppBarTheme(color: Colors.black54),
              textTheme: const TextTheme(
                headlineLarge: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                titleLarge: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
                bodyMedium: TextStyle(
                  fontSize: 14.0,


                ),
              ),
              useMaterial3: true,
              primaryColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.white,
                  background: Colors.black,
                  brightness: Brightness.dark,
                  primary: Colors.white),
            ),
            home: LoginPage(),
            onGenerateRoute: router.generator,
          );
        }
      },
    );
  }
}
