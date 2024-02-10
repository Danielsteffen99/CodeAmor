import 'package:codeamor/infrastructure/repositories/ProfileRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Profile.dart';


class ProfileState extends ChangeNotifier {
  Profile? profile;

  ProfileRepository profileRepository = ProfileRepository();

  ProfileState() {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      setUser(firebaseUser.uid);
    }
  }

  void setUser(String uid) {
    profile = profileRepository.getProfile(uid);
    notifyListeners();
  }

  void removeUser() {
    profile = null;
    notifyListeners();
  }
}