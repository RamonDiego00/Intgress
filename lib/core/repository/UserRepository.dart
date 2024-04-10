import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intgress/services/authenticationService.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/Lesson.dart';
import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/MySnackbar.dart';
import '../database/DB.dart';
import '../database/database.dart'; // Importe sua classe de banco de dados

class UserRepository extends ChangeNotifier {
  late Database db;

  UserRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  Future<void> initialize() async {
    db = await DB.instance.database;
  }

  Future<void> createUser(BuildContext context, User user) async {
    // Salvando localmente
    try {
      await db.insert('users', user.toMap());
      notifyListeners();
    } catch (e) {
      print('Erro ao salvar usuario: $e');
    }
    // Salvando remotamente
    try {

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toMap());


      // AuthenticationService()
      //     .registerUser(
      //         context: context,
      //         name: user.name,
      //         password: user.password,
      //         email: user.email)
      //     .then((String? error) {
      //   if (error != null) {
      //     showSnackBar(context: context, text: error);
      //   } else {
      //     // deu certo
      //     showSnackBar(
      //         context: context,
      //         text: "Cadastro efetuado com sucesso",
      //         isError: false);
      //   }
      // });
    } catch (e) {
      print('Erro ao salvar nota na nuvem: $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await db.insert('users', user.toMap());
      notifyListeners();
    } catch (e) {
      // Trate qualquer erro de inserção aqui
      print('Erro ao atualizar usuario: $e');
    }
  }

  Future<void> deleteUser(User user) async {
    try {
      await db.delete('users', where: 'id = ?', whereArgs: [user.id]);
    } catch (e) {
      print('Erro ao excluir user: $e');
    }
  }
}
