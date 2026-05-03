import 'package:firebase_auth/firebase_auth.dart';

class AutenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get usuarioAtual => _firebaseAuth.currentUser;

  Future<String?> cadastroUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha);

      await userCredential.user!.updateDisplayName(nome);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'O email já está cadastrado';
      }
      return 'Erro desconhecido';
    }
  }

  //Login do usuario
  Future<String?> loginUsuario({
    required String email,
    required String senha,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
