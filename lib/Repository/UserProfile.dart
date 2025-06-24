import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserProfile {

  String collectionName= 'Users';
  FirebaseFirestore db = FirebaseFirestore.instance;

  UserProfile()
  {
  }

  Future<Either<String, String>> setupUser(String name,String bio,String uid) async { 
    try {
      await db.collection(collectionName).doc(uid).set({'name': name, 'bio':bio,});
      return Right('ok');
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }

}
