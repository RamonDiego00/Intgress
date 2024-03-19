import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intgress/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intgress/screens/AnnotationPage.dart';

import '../core/repository/UserRepository.dart';
import '../viewmodel/UserViewModel.dart';

class AuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final UserRepository _userRepository = UserRepository();
  UserViewModel? _userViewModel;

  late String _userUid;

  String getCurrentUIDUser() {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      _userUid = user.uid;
      return _userUid;
    } else {
      return "";
    }
  }

  void _initializeUserViewModel() {
    _userViewModel = UserViewModel(_userRepository);
  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      );

      final UserCredential? userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AnnotationPage()),
        );
      }

      return userCredential;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String?> registerUser({
    required BuildContext context,
    required String name,
    required String password,
    required String email,
  }) async {
    try {

      _initializeUserViewModel();

      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // dá pra pegar várias informações do usuário e até colocar nome
      await user.user!.updateDisplayName(name);

      // salvando remotamente no firestore como uma collection (ideal é mover para um outro arquivo essa lógica)


      final User newUser = User(name: name, email: email, password: password);
      _userViewModel!.registerUser(context, newUser);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user?.uid)
          .set(newUser.toMap());

      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        return "O email já esta em uso";
      }

      return "Erro desconhecido";
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "wrong-password") {
        return "Senha incorreta";
      } else if (e.code == "user-not-found") {
        return "Usuário não encontrado";
      }

      return "Erro desconhecido";
    }
  }

  deleteUser({
    required String password,
    required String email,
  }) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    // dá pra pegar várias informações do usuário e até colocar nome
    // await user.user!.updateDisplayName("displayName");
  }

  updateUser({
    required String password,
    required String email,
  }) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    // dá pra pegar várias informações do usuário e até colocar nome
    // await user.user!.updateDisplayName("displayName");
  }
}
