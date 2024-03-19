import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intgress/core/repository/UserRepository.dart';
import 'package:intgress/screens/AnnotationPage.dart';
import 'package:intgress/screens/ResumeGeneralPage.dart';

import '../core/repository/NoteRepository.dart';
import '../models/Note.dart';
import '../models/User.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  UserViewModel(this._userRepository) {
    _loadApiKey();
    _userRepository.initialize();
  }

  String _apiKey = "";

  Future<void> _loadApiKey() async {
    await dotenv.load(fileName: '.env');
    _apiKey = dotenv.env['API_KEY']!;
  }


  Future<void> registerUser(BuildContext context,User user) async {
    // await _userRepository.initialize();
    await _userRepository.createUser(context,user);
  }

  Future<void> deleteUser(User user) async {
    // await _noteRepository.initialize();
    await _userRepository.deleteUser(user);
  }

  Future<void> updateUser(User user) async {
    // await _noteRepository.initialize();
    await _userRepository.updateUser(user);
  }


  // Navigator.push(
  // context,
  // MaterialPageRoute(
  // builder: (_) => AnnotationPage(),
  // ),
  // );
}
