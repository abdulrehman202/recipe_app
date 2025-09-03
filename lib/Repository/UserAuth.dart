import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/View/all_libs.dart';

class UserAuth {
  Future<Either<String, String>> registerUser(String email, password) async { 
    try {
      UserCredential res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(res.user!.uid);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }

   Future<Either<String, String>> login(String email, password) async {
    try {
      UserCredential loginData =   await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return  Right(loginData.user!.uid);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }

  Future<Either<String, String>> resetPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email,);
          return const Right('Email sent!');
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }
}
