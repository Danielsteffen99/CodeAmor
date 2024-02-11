import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../models/firebase_result.dart';

class UserService {
  late BuildContext context;

  UserService(this.context);

  Future<FirebaseResult<UserCredential>> createUser(String email, String password) async {
    // Create the user in Firebase Authentication
    try {
      var auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return FirebaseResult.success(auth);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.error(e.code);
    } catch (e) {
      return FirebaseResult.error(e.toString());
    }
  }

  Future<FirebaseResult<UserCredential>> login(String email, String password) async {
    try {
      var auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return FirebaseResult.success(auth);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.error(e.code);
    }
  }
}