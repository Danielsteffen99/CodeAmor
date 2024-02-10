import '../../models/Profile.dart';

class ProfileRepository {
  void addProfile(String uid) {
    // TODO Add empty profile to firestore table with uid
  }

  void updateProfile(Profile profile) {
    // TODO Update profile in firestore table
  }

  Profile getProfile(String uid) {
    // TODO Get profile in firestore table by uid
    return Profile("id", "name");
  }
}