import 'package:codeamor/infrastructure/repositories/profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileState extends ChangeNotifier {
  Profile profile = Profile("");

  ProfileRepository profileRepository = ProfileRepository();

  ProfileState() {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      profileRepository.getProfile(firebaseUser.uid).then((p) => {
            if (p != null) {
              setProfile(p)
            }
          });
    }
  }

  bool isUserLoggedIn() {
    return profile.uid.isNotEmpty;
  }

  Profile getProfile() {
    return profile;
  }

  void updateProfileLocal(Profile p) {
    profile = p;
    notifyListeners();
  }

  Future<void> setProfile(Profile p) async {
    profile = p;
    notifyListeners();
  }

  void removeUser() {
    profile = Profile("");
    notifyListeners();
  }
}
