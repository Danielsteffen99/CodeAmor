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
      "gender": profile.gender.name,
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
      "gender": profile.gender.name,
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
        Gender.values.byName(dto.docs.first['gender']),
        dto.docs.first['description'],
        dto.docs.first['image']);
  }

  Future<List<Profile>> getCompatibleProfiles(String uid) async {
    var likerProfile = await db.collection("profiles").where("uid", isEqualTo: uid).get();
    var oppositeGender = "";
    switch (Gender.values.byName(likerProfile.docs.first['gender'])) {
      case Gender.male:
        oppositeGender = "female";
        break;
      case Gender.female:
        oppositeGender = "male";
        break;
    }

    List<Profile> result = [];

    var likes = await db.collection("likes")
        .where("likerUid", isEqualTo: uid)
        .get();
    List<String> alreadyLikedUids = [];
    for (var like in likes.docs) {
      alreadyLikedUids.add(like["likedUid"]);
    }
    
    var profiles = await db.collection("profiles")
        .where("gender", isEqualTo: oppositeGender)
        .get();

    // This should be done on database side, but Firestore does not allow to
    // create a where statement which checks for values not being in an array,
    // where the array exceeds 10 elements, which ours easily could..
    var compatibleProfiles = [];
    for (var cp in profiles.docs) {
      if (alreadyLikedUids.contains(cp["uid"])) continue;
      compatibleProfiles.add(cp);
    }

    for (var p in compatibleProfiles) {
      var t = Profile.full(
          p["uid"],
          p["name"],
          DateTime.fromMillisecondsSinceEpoch((p['birthday'] as Timestamp).millisecondsSinceEpoch),
          Gender.values.byName(p['gender']),
          p["description"],
          p["image"]);
      result.add(t);
    }
    return result;
  }
}