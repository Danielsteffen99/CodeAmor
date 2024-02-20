import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/match.dart';

class MatchRepository {
  final db = FirebaseFirestore.instance;

  Future<void> createMatches(String uid1, String uid2) async {
    var matchTime = DateTime.now();
    final firstMatch = <String, dynamic>{
      "uids": [uid1, uid2],
      "time": matchTime
    };
    await db.collection("matches").add(firstMatch);
  }

  Future<List<Match>> getMatches(String uid) async {
    var dto = await db.collection("matches")
        .where("uids", arrayContains: uid)
        .get();

    List<Match> matches = [];

    for (var match in dto.docs) {
      List<dynamic> ids = match["uids"];
      ids.remove(uid);
      matches.add(Match(match.id, ids.first, DateTime.fromMillisecondsSinceEpoch((dto.docs.first['time'] as Timestamp).millisecondsSinceEpoch)));
    }

    return matches;
  }
}