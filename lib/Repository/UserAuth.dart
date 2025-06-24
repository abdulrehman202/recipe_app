import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  Future<Either<String, String>> registerUser(String email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return const Right('User registered!');
    } on FirebaseAuthException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }

   Future<Either<String, String>> login(String email, password) async {
    try {
      UserCredential loginData =   await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return  Right(loginData.user!.uid);
    } on FirebaseAuthException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }
}
