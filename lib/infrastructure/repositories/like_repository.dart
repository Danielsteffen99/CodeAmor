import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/like.dart';

class LikeRepository {
  final db = FirebaseFirestore.instance;

  Future<void> createLike(String likerUid, String likedUid) async {
    final payload = <String, dynamic>{
      "likerUid": likerUid,
      "likedUid": likedUid,
    };
    await db.collection("likes").add(payload);
  }

  Future<bool> isLiked(String likerUid, String likedUid) async {
    var dto = await db.collection("likes")
        .where("likerUid", isEqualTo: likerUid)
        .where("likedUid", isEqualTo: likedUid)
        .get();

    return dto.docs.isNotEmpty;
  }

}