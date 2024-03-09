import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> registerUser({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // dá pra pegar várias informações do usuário e até colocar nome
      await user.user!.updateDisplayName(name);

      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        return "O email já esta em uso";
      }

      return "Erro desconhecido";
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
}
