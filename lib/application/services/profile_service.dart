import 'package:codeamor/models/firebase_result.dart';
import 'package:flutter/material.dart';
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

 /* Future<FirebaseResult<Profile>> updateProfile() async {
      profile.profile?.name = "Lars";
      await profileRepository.updateProfile(profile.profile!);
      Provider.of<ProfileState>(context, listen: false).setProfile(profile.profile!.uid);
  }*/
}
