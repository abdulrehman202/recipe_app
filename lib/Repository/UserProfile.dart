import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';

class UserProfile {

  String collectionName= 'Users';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Either<String, String>> setupUser(String name,String bio,String uid) async { 
    try {
      await db.collection(collectionName).doc(uid).set({'name': name, 'bio':bio,});
      return Right('ok');
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }

  Future<Either<String, String>> fetchUser(String uid) async { 
    try {
      DocumentSnapshot documentSnapshot = await db.collection(collectionName).doc(uid).get();
      var data = documentSnapshot.data();
      return Right('ok');
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }

}
