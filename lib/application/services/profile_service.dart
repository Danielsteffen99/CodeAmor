import 'dart:convert';

import 'package:codeamor/models/firebase_result.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../infrastructure/repositories/profile_repository.dart';
import '../../models/profile.dart';
import '../../state/profile_state.dart';

class ProfileService {
  var profileRepository = ProfileRepository();
  late BuildContext context;

  ProfileService(BuildContext buildContext) {
    context = buildContext;
  }

  Future<FirebaseResult<Profile>> createProfile(uid) async {
    // Create profile in Firestore
    var p = await profileRepository.createProfile(uid);

    // Ensures the context is mounted
    if (!context.mounted) return FirebaseResult.error("Context is mounted");

    // Sets the profile in the global state
    Provider.of<ProfileState>(context, listen: false).setProfile(p);

    return FirebaseResult.success(p);
  }

  Future<FirebaseResult<Profile>> setLoggedInProfile(uid) async {
    var p = await profileRepository.getProfile(uid);

    if (p == null) {
      return FirebaseResult.error("Profile not found");
    }

    // Ensures the context is mounted
    if (!context.mounted) return FirebaseResult.error("Context is mounted");

    // Sets the profile in the global state
    Provider.of<ProfileState>(context, listen: false).setProfile(p);

    return FirebaseResult.success(p);
  }

  Future<FirebaseResult<Profile>> getProfile(uid) async {
    var p = await profileRepository.getProfile(uid);

    if (p == null) {
      return FirebaseResult.error("Profile not found");
    }

    return FirebaseResult.success(p);
  }

  void logout() {
    Provider.of<ProfileState>(context, listen: false).removeUser();
  }

  Future<FirebaseResult<String>> uploadProfileImage(XFile image, String fileName) async {
    final storage = FirebaseStorage.instance.ref("profile_images");
    List<int> bytes = await image.readAsBytes();
    var base64 = "data:text/plain;base64,${base64Encode(bytes)}";
    try {
      await storage
          .child(fileName)
          .putString(base64, format: PutStringFormat.dataUrl);
    } on FirebaseException catch (e) {
      return FirebaseResult.error(e.code);
    }

    var url = await storage.child(fileName).getDownloadURL();
    return FirebaseResult.success(url);
  }

  Future<FirebaseResult<Profile>> updateProfile(Profile profile) async {
      await profileRepository.updateProfile(profile);
      if (!context.mounted) return FirebaseResult.error("Context is mounted");
      Provider.of<ProfileState>(context, listen: false).setProfile(profile);

      return FirebaseResult.success(profile);
  }
}
