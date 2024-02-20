import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/profile.dart';

class ProfileRepository {
  final db = FirebaseFirestore.instance;

  Future<Profile> createProfile(String uid) async {
    final profile = Profile(uid);
    final payload = <String, dynamic>{
      "uid": profile.uid,
      "name": profile.name,
      "birthday": profile.birthday,
      "gender": profile.gender,
      "description": profile.description,
      "image": profile.image
    };
    await db.collection("profiles").add(payload);
    return profile;
  }

  Future<Profile> updateProfile(Profile profile) async {
    final payload = <String, dynamic>{
      "uid": profile.uid,
      "name": profile.name,
      "birthday": profile.birthday,
      "gender": profile.gender,
      "description": profile.description,
      "image": profile.image
    };

    var dto = await db.collection("profiles").where("uid", isEqualTo: profile.uid).get();
    for (var p in dto.docs) {
      await db.collection("profiles").doc(p.id).update(payload);
    }

    return profile;
  }

  Future<Profile?> getProfile(String uid) async {
    var dto = await db.collection("profiles").where("uid", isEqualTo: uid).get();

    if (dto.docs.isEmpty) return null;

    return Profile.full(
        dto.docs.first['uid'],
        dto.docs.first['name'],
        DateTime.fromMillisecondsSinceEpoch((dto.docs.first['birthday'] as Timestamp).millisecondsSinceEpoch),
        dto.docs.first['gender'],
        dto.docs.first['description'],
        dto.docs.first['image']);
  }

  Future<List<Profile>> getCompatibleProfiles(String uid) async {
    var likerProfile = await db.collection("profiles").where("uid", isEqualTo: uid).get();
    var oppositeGender = "";
    switch (likerProfile.docs.first['gender']) {
      case "male":
        oppositeGender = "female";
        break;
      case "female":
        oppositeGender = "male";
        break;
    }

    List<Profile> profiles = [];

    var compatibleProfiles = await db.collection("profiles")
        .where("gender", isEqualTo: oppositeGender)
        .get();
    for (var p in compatibleProfiles.docs) {
      var t = Profile.full(
          p["uid"],
          p["name"],
          DateTime.fromMillisecondsSinceEpoch((p['birthday'] as Timestamp).millisecondsSinceEpoch),
          p["gender"],
          p["description"],
          p["image"]);
      profiles.add(t);
    }
    return profiles;
  }
}