import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Logar usuario.
  Future<String?> logarUsuario({
    required String email,
    required String senha,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'O Email não estar cadastrado';
        case 'wrong-password':
        case 'invalid-credential':
          return 'Senha ou e-mail incorreta.';
        case 'too-many-requests':
          return 'Muitas tentativas! Seu dispositivo foi bloqueado temporariamente.';
        case 'invalid-email':
          return 'O formato do e-mail é inválido.';
      }
      return e.code;
    }
    // Quando  tudo de certo.
    return null;
  }

  // Deslogar Usuario.
  Future<String?> sairUsuario() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  // Redefinir senha.
  Future<String?> redefinirSenha({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
